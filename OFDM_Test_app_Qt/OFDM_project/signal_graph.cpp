#include "signal_graph.h"


SignalGraph::SignalGraph(QGroupBox* groupBox)
{
    plot = new QCustomPlot(groupBox);
    AddGraph(QColor(0,0,0), 0);
    plot->setObjectName(QString::fromUtf8("Graph"));
    plot->setGeometry(QRect(10, 100, 750, 400));
    plot->setStyleSheet(QString::fromUtf8("background-color: rgb(128,128,128);"));

    QLinearGradient gradient(0, 0, 0, 400);
    gradient.setColorAt(0, QColor(128, 128, 128));
    gradient.setColorAt(0.38, QColor(128, 128, 128));
    gradient.setColorAt(1, QColor(128, 128, 128));
    plot->setBackground(QBrush(gradient));
    plot->setInteractions(QCP::iRangeDrag | QCP::iRangeZoom | QCP::iSelectPlottables);


    plot->xAxis->setLabel("Время, с");
    plot->yAxis->setLabel("Амплитуда, В");

    plot->replot();
}

SignalGraph::~SignalGraph() {
    delete plot;
}

void SignalGraph::PlotGraph(QByteArray& data) {

    int integer = 0;
    int digit = 1;
    for (int i = 0; i < 8; ++i) {
        if (data.at(1) & (1 << i)) {
            integer += digit;
        }
        digit *= 2;
    }

    if(data.at(1) & 0x80) {
        integer = -1*(~integer & 0xFF);
        data[0] = (~data[0]) + 1;
    }

    float result = 0.0;
    float fraction = 0.5;
    for (int i = 0; i < 8; ++i) {
        if (data.at(0) & (1 << (7 - i))) {
            result += fraction;
        }
        fraction /= 2.0;
    }

    if(data.at(1) & 0x80) {
        result = -1*result;
    }

    float sig_instant = ( integer + result ) / 32.0f;

    if(first_in == 0) {
        start_time = GetTickCount();
        first_in = 1;
    }

    //AutoAxisScale();

    Time.append((GetTickCount() - start_time) / 1000);
    Signal.append(sig_instant);

    plot->graph(0)->setData(Time, Signal);
    plot->replot();
}

void SignalGraph::SaveGraphAs() {
    QLinearGradient gradient(0, 0, 0, 400);
    gradient.setColorAt(0, QColor(255, 255, 255));
    gradient.setColorAt(0.38, QColor(255, 255, 255));
    gradient.setColorAt(1, QColor(255, 255, 255));
    plot->setBackground(QBrush(gradient));

    QString filename = QFileDialog::getSaveFileName();

    if( filename.endsWith(".png") ){
        plot->savePng(filename, plot->width(), plot->height() );
    }
    if( filename.endsWith(".jpg") ){
        plot->saveJpg(filename, plot->width(), plot->height() );
    }
    if( filename.endsWith(".jpeg") ){
        plot->saveJpg(filename, plot->width(), plot->height() );
    }
    if( filename.endsWith(".pdf") ){
        plot->savePdf(filename, plot->width(), plot->height() );
    }

    //If we get this far then save as a png
    plot->savePng(filename, plot->width(), plot->height());

    gradient.setColorAt(0, QColor(128, 128, 128));
    gradient.setColorAt(0.38, QColor(128, 128, 128));
    gradient.setColorAt(1, QColor(128, 128, 128));
    plot->setBackground(QBrush(gradient));
}

void SignalGraph::AddGraph(QColor color, uint8_t sensor_number) {
    plot->addGraph();
    QPen pen;
    pen.setWidth(2);
    pen.setColor(color);
    plot->graph(sensor_number)->setPen(pen);

    XRange.first = 0;
    XRange.second = 5;

    plot->xAxis->setRange(XRange.first, XRange.second);
    plot->yAxis->setRange(0.3, -0.3);
}

void SignalGraph::ClearGraphs() {
    Time.clear();
    Signal.clear();
    start_time = 0;
    plot->clearGraphs();
    AddGraph(QColor(0,0,0), 0);
    plot->replot();
}

void SignalGraph::AutoAxisScale() {
    XRange.first = 0;
    XRange.second = (GetTickCount() - start_time) / 1000 + (XRange.second - XRange.first) / 10;

    plot->xAxis->setRange(XRange.first, XRange.second);
}


