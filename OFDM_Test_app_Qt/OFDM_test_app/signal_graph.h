#ifndef SIGNAL_GRAPH_H
#define SIGNAL_GRAPH_H

#include <QObject>
#include <QVector>
#include <QPair>
#include <QElapsedTimer>
#include <QByteArray>
#include "qcustomplot.h"

class SignalGraph
{
public:

private:
    QCustomPlot* plot;
    //vectors for plot graph
    QVector<double> Time, Signal;
    //XRange and Yrange for Graph obviously and YMinmax for more accurate auto scale axis with considering min and max y value
    QPair<double, double> XRange, YRange;
    size_t first_in = 0;
    double start_time = 0;

public:
    //need to get GroupBox to constuctor in order to place QCustomPlot in widget in GropuBox
    SignalGraph(QGroupBox* groupBox);
    ~SignalGraph();
    void PlotGraph(QByteArray&);
    void SaveGraphAs();
    void AddGraph(QColor color, uint8_t sensor_number);
    void ClearGraphs();
    void AutoAxisScale();
    void SetRange(double x_low, double x_up, double y_low, double y_up);
    QCustomPlot* GetPlot();
    QPair<double, double> GetXRange();
    QPair<double, double> GetYRange();
};

#endif // SIGNAL_GRAPH_H
