import * as React from "react";
import RainRadarTime from "./RainradarTime";
// The interface for our API response

const tilesRow1 = ["&x=1024&y=768", "&x=1280&y=768", "&x=1536&y=768"];
const tilesRow2 = ["&x=1024&y=1024", "&x=1280&y=1024", "&x=1536&y=1024"];

type ImageDescriptions = {
  timestamp: string;
  query: {
    version: string;
    production_line: string;
    id: string;
    hash: string;
  };
  designation: string;
};

export interface Props {}

export interface State {
  currentIndex: number;
  intervalId: number;
  imageDescriptions: [ImageDescriptions];
  loading: boolean;
  imagesLoaded: number;
}

export default class Rainradar extends React.Component<Props, State> {
  constructor(props: {}) {
    super(props);
    this.state = {
      imageDescriptions: null,
      loading: true,
      currentIndex: 0,
      intervalId: 0,
      imagesLoaded: 0
    };

    // Get the data from our API.
    fetch("/api/rainradar")
      .then(response => response.json() as Promise<string>)
      .then(data => {
        this.setState({
          imageDescriptions: JSON.parse(data),
          loading: false,
          currentIndex: 0
        });
      });
  }

  componentDidMount() {
    const intervalId = setInterval(this.updateTimer, 1000);
    this.setState({ intervalId });
  }
  componentWillUnmount() {
    clearInterval(this.state.intervalId);
  }

  updateTimer = () => {
    const currentIndex = this.state.currentIndex;

    if (currentIndex < this.state.imageDescriptions.length - 1) {
      const newIndex = currentIndex + 1;

      this.setState({ currentIndex: newIndex });
    } else {
      this.setState({ currentIndex: 0 });
    }
  };

  onLoadImage = () => {
    const { imagesLoaded } = this.state;
    this.setState({ imagesLoaded: imagesLoaded + 1 });
  };

  radarTile = (currentImage, value) => {
    return (
      <img
        key={currentImage.timestamp + value}
        alt="rain radar tile"
        className="regen1"
        data-timestamp={currentImage.timestamp}
        src={`/tiles?hash=${currentImage.query.hash}&id=${
          currentImage.timestamp
        }&jpg_quality=80&production_line=${
          currentImage.query.production_line
        }&s=M0120&size=256&version=${
          currentImage.query.version
        }&wrextent=europe${value}`}
        onLoad={this.onLoadImage}
      />
    );
  };

  render() {
    const loading =
      this.state.loading || this.state.imagesLoaded < 96 ? (
        <div className="loading-spinner my-5">
          <i className="fa fa-refresh fa-spin fa-3x fa-fw" />
          <span className="sr-only">Loading...</span>
        </div>
      ) : null;

    const allImages = this.state.loading
      ? null
      : this.state.imageDescriptions.map((currentImage, index) => {
          let display = "none";
          if (this.state.imagesLoaded === 96) {
            display = index === this.state.currentIndex ? "inline" : "none";
          }
          const row1 = tilesRow1.map(value =>
            this.radarTile(currentImage, value)
          );
          const row2 = tilesRow2.map(value =>
            this.radarTile(currentImage, value)
          );
          return (
            <div
              key={currentImage.timestamp}
              className="text-nowrap"
              style={{ display: display }}
            >
              {row1}
              <br />
              {row2}
            </div>
          );
        });
    const time = this.state.loading ? null : this.state.imagesLoaded === 96 ? (
      <RainRadarTime
        timestamp={
          this.state.imageDescriptions[this.state.currentIndex].timestamp
        }
      />
    ) : null;

    return (
      <div>
        {loading}
        {time}
        {allImages}
      </div>
    );
  }
}
