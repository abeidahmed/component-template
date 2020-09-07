const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  purge: ['./app/views/**/*.html.erb', './app/javascript/components/**/*.vue'],
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
        '40': '0.4',
        ...defaultTheme.opacity,
      },
    },
  },
  variants: {
    opacity: ['responsive', 'group-hover'],
  },
  plugins: [require('@tailwindcss/ui')],
};
