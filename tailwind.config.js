const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  purge: [],
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
    },
  },
  variants: {},
  plugins: [require('@tailwindcss/ui')],
};
