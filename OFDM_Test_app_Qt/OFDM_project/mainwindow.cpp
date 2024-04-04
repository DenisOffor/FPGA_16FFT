#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    my_com_port = new com_port();
    my_com_port->Open("COM13");

    MyGraph = new SignalGraph(ui->groupBox);

    TimerForGraph = new QTimer();
    TimerForGraph->start(DISCRETIZATION_TIME);

    connect(TimerForGraph, &QTimer::timeout, this, &MainWindow::Slot_PlotGraph);
    connect(my_com_port, &com_port::sig_FFT_in_buffer, this, &MainWindow::Slot_GetNewData);
    connect(ui->pushButton, &QPushButton::clicked, this, &MainWindow::Slot_SendTestData);
}

MainWindow::~MainWindow()
{
    delete TimerForGraph;
    delete MyGraph;
    delete my_com_port;
    delete ui;
}

void MainWindow::Slot_PlotGraph() {
    QByteArray temp;
    if(GraphDataBuffer.isEmpty()) {
        temp.append(char(0));
        temp.append(char(0));
        MyGraph->PlotGraph(temp);
    }
    else {
        temp.append(GraphDataBuffer.at(0));
        GraphDataBuffer.remove(0,1);
        temp.append(GraphDataBuffer.at(0));
        GraphDataBuffer.remove(0,1);
        MyGraph->PlotGraph(temp);
    }
}

void MainWindow::Slot_GetNewData(QByteArray Rx_buufer) {
    GraphDataBuffer.append(Rx_buufer);
}

void MainWindow::Slot_SendTestData() {
    my_com_port->slot_SendData((char)0b00010011);
}
