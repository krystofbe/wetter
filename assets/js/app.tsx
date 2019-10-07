import * as React from "react";
import * as ReactDOM from "react-dom";
import { BrowserRouter } from "react-router-dom";
import University from "./components/University";
import Rainradar from "./components/Rainradar";

// webpack automatically concatenates all files in your
// watched paths. Those paths can be configured as
// endpoints in "webpack.config.js".
//
// Import dependencies
//

// This code starts up the React app when it runs in a browser. It sets up the routing
// configuration and injects the app into a DOM element.
ReactDOM.render(<University />, document.getElementById("temperature-data"));
ReactDOM.render(<Rainradar />, document.getElementById("rainradar"));
