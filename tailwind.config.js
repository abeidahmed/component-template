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
    },
  },
  variants: {
    opacity: ['responsive', 'group-hover'],
    borderWidth: ['responsive', 'first'],
  },
  plugins: [require('@tailwindcss/ui')],
};
