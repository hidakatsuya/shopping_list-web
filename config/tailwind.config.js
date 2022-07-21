const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        'md-primary': 'rgb(var(--color-md-primary) / <alpha-value>)',
        'md-primary-variant': 'rgb(var(--color-primary-variant) / <alpha-value>)',
        'md-secondary': 'rgb(var(--color-md-secondary) / <alpha-value>)',
        'md-secondary-variant': 'rgb(var(--color-md-secondary-variant) / <alpha-value>)',
        'md-background': 'rgb(var(--color-md-background) / <alpha-value>)',
        'md-surface': 'rgb(var(--color-md-surface) / <alpha-value>)',
        'md-error': 'rgb(var(--color-md-error) / <alpha-value>)',
        'md-on-primary': 'rgb(var(--color-md-on-primary) / <alpha-value>)',
        'md-on-secondary': 'rgb(var(--color-md-on-secondary) / <alpha-value>)',
        'md-on-background': 'rgb(var(--color-md-on-background) / <alpha-value>)',
        'md-on-surface': 'rgb(var(--color-md-on-surface) / <alpha-value>)',
        'md-on-error': 'rgb(var(--color-md-on-error) / <alpha-value>)'
      },
      container: {
        center: true,
        padding: '2rem',
        screens: {
          sm: '640px',
          md: '768px'
        }
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms')
  ]
}
