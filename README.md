# Purlin

Purlin provides a common foundation for your [PureScript](https://www.purescript.org/) projects.

## Usage

To get started with Purlin you'll want to install it as a dev dependency:

#### Yarn

```sh
yarn add -D purlin
```

#### npm

```sh
npm i -D purlin
```

Once Purlin is installed you can configure your desired scripts, like so:

```diff json
{
  "scripts": {
+    "format": "purlin format"
  }
}
```

## Motivation

In a sense, Purlin fills the same role as a project template or generator: a way to get a consistent environment for any PureScript project. However, forking a project template or using a generator to scaffold a project provides no value after the initial project creation. These tools serve as a starting point, but are essentially useless once the project has been setup.

Purlin takes a page out of the [`react-scripts`](https://github.com/facebook/create-react-app/tree/master/packages/react-scripts) handbook and is a single dependency that can be installed initially and then upgraded over time.

We use npm as the distribution mechanism for Purlin due to its convenience. Much of the PureScript and PureScript-adjacent tooling (like [Spago](https://github.com/purescript/spago), [Purty](https://gitlab.com/joneshf/purty), and [Bower](https://bower.io/)) already exists on the npm registry, which makes it easy for us to include these dependencies with Purlin. Additionally, many PureScript projects will be using npm anyways, so installing Purlin is as easy as installing any other npm dependency.
