import * as React from "react";
import { Button, Table } from "reactstrap";
import SunriseSunset from "./SunriseSunset";
import { DateTime, Interval } from "luxon";

// The interface for our API response
interface ApiResponse {
  windSpeed: number;
  measuredAt: string;
  temperature: string;
  description: string;
}

interface UniversityData {
  windSpeed: number;
  temperature: string;
  description: string;
  measuredAt: string;
}

interface State {
  universityData?: UniversityData;
  loading: boolean;
}
const MAX_ALLOWED_TIME_DIFFEENCE_IN_HOURS = 1;

export default class University extends React.Component<{}, State> {
  renderError = (universityData: UniversityData) => {
    return (
      <div>
        <div className="alert alert-danger" role="alert">
          <i className="fa fa-info-circle mr-1" />
          Die Temperaturangaben der WWU sind vom{" "}
          <strong>{universityData.measuredAt} Uhr</strong>, also leider
          veraltet. Das kannst Du{" "}
          <a
            href="https://www.uni-muenster.de/Klima/wetter/wetter.php"
            className="alert-link"
          >
            hier
          </a>{" "}
          überprüfen. Probier' es in ein paar Minuten nochmal, vielleicht
          funktioniert es dann wieder!
        </div>
      </div>
    );
  };

  renderUniversityDataTable = (universityData: UniversityData) => {
    return (
      <div>
        <h1>
          {universityData.temperature} &deg;C
          <small className="ml-2">im Schlossviertel</small>
        </h1>
        <span className="badge badge-success mx-1">
          <i className="fa fa-cloud mr-1" />
          {universityData.description}
        </span>
        <span className="badge badge-primary mx-1">
          <i className="fa fa-flag mr-1" />
          {universityData.windSpeed}
        </span>
        <SunriseSunset latitude={51.9606649} longitude={7.6261347} />
      </div>
    );
  };

  constructor(props: {}) {
    super(props);
    this.state = { universityData: null, loading: true };

    // Get the data from our API.
    fetch("/api/university_data")
      .then(response => response.json() as Promise<ApiResponse>)
      .then(data => {
        this.setState({
          universityData: data,
          loading: false
        });
      });
  }
  renderSpinner = () => {
    return (
      <div className="loading-spinner">
        <i className="fa fa-refresh fa-spin fa-3x fa-fw" />
        <span className="sr-only">Loading...</span>
      </div>
    );
  };

  renderErrorOrDataTable = (universityData: UniversityData) => {
    const measuredAt = DateTime.fromFormat(
      universityData.measuredAt,
      "dd.LL.yyyy HH:mm"
    );
    const maxAllowedPastTime = DateTime.local().minus({
      hours: MAX_ALLOWED_TIME_DIFFEENCE_IN_HOURS
    });

    if (measuredAt < maxAllowedPastTime) {
      return this.renderError(universityData);
    } else {
      return this.renderUniversityDataTable(universityData);
    }
  };

  public render(): JSX.Element {
    const content = this.state.loading
      ? this.renderSpinner()
      : this.renderErrorOrDataTable(this.state.universityData);
    return content;
  }
}
