// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin");

module.exports = {
  content: ["./js/**/*.js", "../lib/*_web.ex", "../lib/*_web/**/*.*ex"],
  safelist: [
    {
      pattern: /hljs+/,
    },
  ],
  theme: {
    extend: {
      colors: {
        brand: "#FD4F00",
      },
      typography: (theme) => ({
        DEFAULT: {
          css: {
            maxWidth: null,
            pre: {
              color: theme("colors.gray.1000"),
              backgroundColor: "#282c34", // background color of atom-one-dark theme in highlight.js
            },
            "pre code::before": {
              paddingLeft: "unset",
            },
            "pre code::after": {
              paddingRight: "unset",
            },
            code: {
              backgroundColor: theme("colors.gray.100"),
              color: theme("colors.red.600"),
              padding: "0 0.1rem",
              fontWeight: "500",
              borderRadius: "0.25rem",
            },
            "code::before": {
              content: '""',
              paddingLeft: "0.25rem",
            },
            "code::after": {
              content: '""',
              paddingRight: "0.25rem",
            },
            a: {
              color: theme("colors.purple.500"),
              transitionProperty: "all",
              transitionTimingFunction: "cubic-bezier(0.4, 0, 0.2, 1)",
              transitionDuration: "150ms",
            },
            "a:hover": {
              color: theme("colors.purple.700"),
            },
          },
        },
      }),
    },
    hljs: {
      theme: "atom-one-dark",
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/typography"),
    require("tailwind-highlightjs"),
    plugin(({ addVariant }) =>
      addVariant("phx-no-feedback", [".phx-no-feedback&", ".phx-no-feedback &"])
    ),
    plugin(({ addVariant }) =>
      addVariant("phx-click-loading", [
        ".phx-click-loading&",
        ".phx-click-loading &",
      ])
    ),
    plugin(({ addVariant }) =>
      addVariant("phx-submit-loading", [
        ".phx-submit-loading&",
        ".phx-submit-loading &",
      ])
    ),
    plugin(({ addVariant }) =>
      addVariant("phx-change-loading", [
        ".phx-change-loading&",
        ".phx-change-loading &",
      ])
    ),
  ],
};
