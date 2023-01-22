module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/components/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],

  theme: {
    extend: {
      colors: {
        primary: "#24292e",
        secondary: "#1f2428",
        tertiary: "#2f363d",
        border: "#1b1f23",
      },
    },
  },
};
