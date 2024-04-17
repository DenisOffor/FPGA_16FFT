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

    TimerForSendData = new QTimer();
    TimerForSendData->start(SEND_TIME);

    connect(TimerForGraph, &QTimer::timeout, this, &MainWindow::Slot_PlotGraph);
    connect(TimerForSendData, &QTimer::timeout, this, &MainWindow::Slot_SendData);
    connect(my_com_port, &com_port::sig_FFT_in_buffer, this, &MainWindow::Slot_GetNewData);
    connect(ui->LineEdit, &QLineEdit::textEdited, this, &MainWindow::Slot_AddNewDataInBuf);

    connect(ui->XMinLineEdit, &QLineEdit::editingFinished, this, &MainWindow::Slot_ManualAxisScale);
    connect(ui->XMaxLineEdit, &QLineEdit::editingFinished, this, &MainWindow::Slot_ManualAxisScale);
    connect(ui->YMinLineEdit, &QLineEdit::editingFinished, this, &MainWindow::Slot_ManualAxisScale);
    connect(ui->YMaxLineEdit, &QLineEdit::editingFinished, this, &MainWindow::Slot_ManualAxisScale);

    connect(MyGraph->GetPlot(), &QCustomPlot::mouseWheel, this, &MainWindow::Slot_MouseAxisScale);
    connect(MyGraph->GetPlot(), &QCustomPlot::mouseMove, this, &MainWindow::Slot_MouseAxisScale);

     connect(ui->BtnSaveAs, &QPushButton::clicked, this, &MainWindow::Slot_SaveGraphAs);
}

MainWindow::~MainWindow()
{
    delete TimerForGraph;
    delete MyGraph;
    delete my_com_port;
    delete ui;
}

void MainWindow::Slot_SaveGraphAs() {
    MyGraph->SaveGraphAs();
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

void MainWindow::Slot_AddNewDataInBuf() {
    int diffLength = ui->LineEdit->text().length() - Buf_for_transfer.length();
    if (diffLength > 0) {
        QString addedText = ui->LineEdit->text().right(diffLength);
        Buf_for_transfer.append(addedText.toUtf8());
    }
}

void MainWindow::Slot_SendData() {
    if(Buf_for_transfer.length() != i) {
        my_com_port->slot_SendData(Buf_for_transfer.at(i++));
    }
}

void MainWindow::Slot_MouseAxisScale() {
    MyGraph->SetRange(MyGraph->GetPlot()->xAxis->range().lower, MyGraph->GetPlot()->xAxis->range().upper,
                      MyGraph->GetPlot()->yAxis->range().lower, MyGraph->GetPlot()->yAxis->range().upper);

    ui->XMinLineEdit->setText(QString::number(round(MyGraph->GetXRange().first)));
    ui->XMaxLineEdit->setText(QString::number(round(MyGraph->GetXRange().second)));

    ui->YMinLineEdit->setText(QString::number(round(MyGraph->GetYRange().first)));
    ui->YMaxLineEdit->setText(QString::number(round(MyGraph->GetYRange().second)));
}

void MainWindow::Slot_ManualAxisScale() {
    MyGraph->SetRange(ui->XMinLineEdit->text().toDouble(), ui->XMaxLineEdit->text().toDouble(),
                      ui->YMinLineEdit->text().toDouble(), ui->YMaxLineEdit->text().toDouble());
}
