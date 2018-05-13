import * as React from "react";

export interface Props {
  timestamp: string;
}

export default class RainradarTime extends React.Component<Props, {}> {
  berechneUhrzeit = (datumUngeparst: string) => {
    // 201701019-1830

    const utcDate = new Date();
    utcDate.setUTCFullYear(Number(datumUngeparst.substring(0, 4)));
    utcDate.setUTCMonth(Number(datumUngeparst.substring(4, 6)) - 1);
    utcDate.setUTCDate(Number(datumUngeparst.substring(6, 8)));
    utcDate.setUTCHours(Number(datumUngeparst.substring(9, 11)));
    utcDate.setUTCMinutes(Number(datumUngeparst.substring(11, 13)));
    utcDate.setUTCSeconds(0);
    return utcDate;
  };

  render() {
    const utcDate = this.berechneUhrzeit(this.props.timestamp);
    let time = "";
    if (utcDate > new Date()) {
      time = utcDate.toLocaleString() + " Prognose ";
    } else {
      time = utcDate.toLocaleString();
    }
    return <div className="rainradar__headline">{time}</div>;
  }
}
