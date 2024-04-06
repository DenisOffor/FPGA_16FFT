#include "com_port.h"

com_port::com_port()
{
    Tx_parcel = new QByteArray();
    port = new QSerialPort();
}

com_port::~com_port()
{
    Close();
    delete Tx_parcel;
    delete port;
}

bool com_port::Open(const QString &name_port)
{
    port->setPortName(name_port);
    bool status = port->open(QIODevice::ReadWrite);
    assert(status == true);

    int status_error = SetUp();
    emit sig_Opened(name_port, status_error);

    connect(port, &QSerialPort::readyRead, this, &com_port::Port_GetData);

    return (status_error == 0 ? true : false);
}

void com_port::Close()
{
    port->close();
}

int com_port::SetUp()
{
    int status_error = 0;
    status_error =  port->setBaudRate(QSerialPort::Baud115200) == false ? (1 << 0) :
    port->setDataBits(QSerialPort::Data8) == false ? (1 << 1) :
    port->setFlowControl(QSerialPort::NoFlowControl) == false ? (1 << 2) :
    port->setParity(QSerialPort::NoParity) == false ? (1 << 3) :
    port->setStopBits(QSerialPort::OneStop) == false ? (1 << 4) : 0;

    if (!port->isOpen()) {
        status_error = 0xFF;
    }
    return status_error;
}

void com_port::Port_GetData()
{
    Rx_buffer = port->readAll();
    QByteArray temp = Rx_buffer;

    //for(int i = 63, j = 2; i > 1; i -= 2, j += 2) {
    //    temp[j] = Rx_buffer[i-1];
    //    temp[j+1] = Rx_buffer[i];
    //}

    emit sig_FFT_in_buffer(temp);
}

void com_port::slot_SendData(char data)
{
    Tx_parcel->clear();
    Tx_parcel->append(data);

    if (!port->isOpen()) {
        return;
    }

    port->write(*Tx_parcel);
    port->waitForBytesWritten(-1);
}

// void com_port::slot_SendData(const char &cmd, const QByteArray data) {
//     Tx_parcel->clear();
//     Tx_parcel->append(START_BYTE);
//     Tx_parcel->append(cmd);
//     Tx_parcel->append(data.size());
//     Tx_parcel->append(((data.size() & 0xFF00) >> 8));
//     Tx_parcel->append(data);
//     Tx_parcel->append(END_BYTE);

//     this_port->write(*Tx_parcel);
//     while(!this_port->waitForBytesWritten(-1));
//     for(int i = 0; i < 1000; i++);
// }
