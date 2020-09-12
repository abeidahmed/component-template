<template>
  <svg
    xmlns="http://www.w3.org/2000/svg"
    :viewBox="viewBox"
    :fill="modifier === 'solid' ? 'currentColor' : 'none'"
    :stroke="modifier === 'stroke' ? 'currentColor' : 'none'"
  >
    <slot />
  </svg>
</template>

<script>
export default {
  name: 'icon-base',
  props: {
    viewBox: {
      type: String,
      required: true,
    },
    modifier: {
      type: String,
      required: true,
    },
  },
};
</script>