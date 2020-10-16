const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  purge: [
    './app/views/**/*.html.erb',
    './app/javascript/components/**/*.vue',
    './app/components/**/*.html.erb',
    './app/pages/**/*.html.erb',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter', ...defaultTheme.fontFamily.sans],
      },
      cursor: {
        'ew-resize': 'ew-resize',
        ...defaultTheme.cursor,
      },
      maxWidth: {
        '8xl': '90rem',
        ...defaultTheme.maxWidth,
      },
      opacity: {
        '15': '0.15',
        '30': '0.3',
        ...defaultTheme.opacity,
      },
      height: {
        ...defaultTheme.height,
        '140': '36rem',
      },
      boxShadow: {
        ...defaultTheme.boxShadow,
        custom:
          'rgba(101, 119, 134, 0.2) 0px 0px 15px, rgba(101, 119, 134, 0.15) 0px 0px 3px 1px',
      },
    },
  },
  variants: {
    opacity: ['responsive', 'group-hover'],
    borderWidth: ['responsive', 'first'],
  },
  plugins: [require('@tailwindcss/ui')],
};
