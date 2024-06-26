#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QTimer>
#include "com_port.h"
#include "signal_graph.h"

#define DISCRETIZATION_TIME 31 //in ms
#define SEND_TIME 20 //in ms

QT_BEGIN_NAMESPACE
namespace Ui {
class MainWindow;
}
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT
public:
    com_port* my_com_port;
    SignalGraph* MyGraph;
    QTimer* TimerForGraph;
    QTimer* TimerForSendData;
    QByteArray Buf_for_transfer;
    int i = 0;
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

public slots:
    void Slot_PlotGraph();
    void Slot_GetNewData(QByteArray);
    void Slot_AddNewDataInBuf();
    void Slot_SendData();
private:
    Ui::MainWindow *ui;
    QByteArray GraphDataBuffer;
};
#endif // MAINWINDOW_H
