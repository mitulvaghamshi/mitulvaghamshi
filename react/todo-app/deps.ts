export * as ReactDOM from "https://jspm.dev/react-dom@18.2.0/client";

import * as React from "https://jspm.dev/react@18.2.0";

const { default: any, ...rest } = React;
const react = React.default;

export { react as React };
export { rest as react };
