// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")

const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/onesen_web.ex",
    "../lib/onesen_web/**/*.*ex"
  ],
  theme: {
    extend: {
      colors: {
        // https://coolors.co/e6e6e6-39393a-e77728-008148-ba324f
        platinum: "#E6E6E6",
        jet: "#39393A",
        pumpkin: "#E77728",
        seagreen: "#008148",
        rosered: "#BA324F"
      },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      }
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    // Allows prefixing tailwind classes with LiveView classes to add rules
    // only when LiveView classes are applied, for example:
    //
    //     <div class="phx-click-loading:animate-ping">
    //
    plugin(({ addVariant }) => addVariant("phx-no-feedback", [".phx-no-feedback&", ".phx-no-feedback &"])),
    plugin(({ addVariant }) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
    plugin(({ addVariant }) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
    plugin(({ addVariant }) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"]))
  ]
}
