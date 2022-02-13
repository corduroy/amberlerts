# amberlerts
SwiftUI App to interact with the Amber Electric API

# What is Amber?
[Amber](https://www.amber.com.au) is an Australian electricity company that retails electricity based on the current, variable wholesale electricity price. The price can be _very high_, or also _very low_. So it's useful to be always aware of how much I'm currently paying.

# What does this app do?
This app currently shows the most-recent, current, and future (forecast) electricity prices, on Watch, iPhone, iPad and Mac (the last two aren't pretty!). Prices are colour-coded based on price, and the current price is highlighted.

# Why does this app exist?
Amber have a nice iPhone app. It does the basic job well. But I asked myself, with a nice [Public API](https://app.amber.com.au/developers), and some time on the weekend, could I get a really simple app up and running that did more?

### Play with SwiftUI
So, to start with, since Amber has a simple and well-described [REST API](https://app.amber.com.au/developers), it seemed like a nice way to explore SwiftUI, after 5+ years of writing no code at all.

As I got started, I discovered that there's not a lot of sample code that describes a basic app that pulls data from a REST API, and populates an interface with that data. I've tried to use basic, current best-practice approaches, based on the various sources around the web, and my own (non-current) experience. I hope this app might help others who are getting started with SwiftUI too.

### Have a Watch app
There's no official Watch app. I wrote a Shortcut to get my current electricity price, but I wanted More. Can I get my Amber prices on my wrist? (Spoiler: yes!)

### Watch Complications, and iPhone widgets
Wouldn't it be great to have a watch complication so I can know my current price at a glance? Or an iPhone widget? How even do you create these things? This is my tool to find out. (WIP)

# Required Configuration

### How to Configure your API Key
1. Create Shared/APIConfig.xcconfig
2. Add `APIKey = {YOUR API KEY}`
3. In the Project file, add this config file as a Configuration.
4. Add APIKey = ${APIKey} to the Info file
4. Done.

### How to Configure your developer account and bundle ID
Yeah, I've completely forgotten how to do this. Work it out. Maybe make a PR with instructions?
