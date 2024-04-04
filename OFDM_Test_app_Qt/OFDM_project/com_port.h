#ifndef COM_PORT_H
#define COM_PORT_H

#include <QObject>
#include <QSerialPort>
#include <QByteArray>

class com_port : public QObject
{
    Q_OBJECT
public:
    QSerialPort *port;
    QByteArray* Tx_parcel;
    QByteArray Rx_buffer;

    com_port();
    ~com_port();

    bool Open(const QString& name_port);
    void Close();
    int SetUp();

signals :
    void sig_Opened(const QString& port_name, int status_error);
    void sig_FFT_in_buffer(const QByteArray Rx_buffer);
public slots:
    void Port_GetData();
    void slot_SendData(char);
};
#endif // COM_PORT_H
