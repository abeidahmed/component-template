<template>
  <div class="sm:px-4">
    <div class="mt-6 overflow-hidden border-t border-b sm:border sm:rounded-lg">
      <div
        class="flex items-center justify-between px-4 py-2 bg-white border-b border-gray-200 sm:py-4 sm:px-6 sm:items-baseline"
      >
        <div>
          <p class="text-base leading-snug truncate font-regular md:text-lg">
            {{ title }}
          </p>
        </div>
        <div class="items-center hidden sm:flex">
          <div class="flex items-center">
            <button
              class="inline-block px-3 py-2 ml-2 font-medium leading-none rounded-lg focus:outline-none hover:text-indigo-600 focus:text-indigo-600"
              :class="
                !showCode ? 'text-indigo-700 bg-indigo-100' : 'text-gray-500'
              "
              @click="showCode = false"
            >
              Preview
            </button>
            <button
              class="inline-block px-3 py-2 ml-2 font-medium leading-none rounded-lg focus:outline-none hover:text-indigo-600 focus:text-indigo-600"
              :class="
                showCode ? 'text-indigo-700 bg-indigo-100' : 'text-gray-500'
              "
              @click="showCode = true"
            >
              Code
            </button>
          </div>
          <div ref="clipboard" class="flex items-center">
            <div class="self-stretch pl-3 pr-4">
              <div class="h-full border-l border-gray-200"></div>
            </div>
            <button
              class="inline-flex items-center justify-center text-gray-500 hover:text-gray-700"
              @click="copy"
            >
              <svg viewBox="0 0 20 20" fill="currentColor" class="w-5 h-5">
                <path d="M8 3a1 1 0 011-1h2a1 1 0 110 2H9a1 1 0 01-1-1z"></path>
                <path
                  d="M6 3a2 2 0 00-2 2v11a2 2 0 002 2h8a2 2 0 002-2V5a2 2 0 00-2-2 3 3 0 01-3 3H9a3 3 0 01-3-3z"
                ></path>
              </svg>
            </button>
          </div>
        </div>
        <div class="sm:hidden">
          <button
            class="inline-block px-3 py-3 font-medium leading-none text-gray-500 rounded-lg focus:outline-none"
          >
            Code
          </button>
        </div>
      </div>
      <div v-show="!showCode" class="bg-gray-500">
        <div class="flex resizer">
          <div class="flex-1">
            <iframe
              ref="iframe"
              :srcdoc="content"
              frameborder="0"
              class="w-full"
              :style="{ height: frameHeight }"
            ></iframe>
          </div>
          <div
            class="relative flex-shrink-0 hidden w-4 bg-gray-100 border-l md:block resizer-right cursor-ew-resize"
          ></div>
        </div>
      </div>
      <div v-show="showCode">
        <pre
          class="block px-4 py-0 m-0 overflow-x-auto leading-normal language-html"
        >
          <code class="scrolling-touch text-sm antialiased language-html">
            {{ content }}
          </code>
        </pre>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    template: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      title: this.template.front_matter.title,
      content: this.template.content,
      frameHeight: '',
      showCode: false,
    };
  },
  methods: {
    copy() {
      const textarea = document.createElement('textarea');
      textarea.value = this.content;
      textarea.style.position = 'fixed';
      textarea.style.left = '-9999999px';
      this.$refs.clipboard.append(textarea);
      textarea.focus();
      textarea.select();
      document.execCommand('copy');
      this.$refs.clipboard.removeChild(textarea);
    },
  },
  computed: {
    computeHeight() {
      this.frameHeight =
        this.$refs.iframe.contentWindow.document.body.scrollHeight + 'px';
    },
  },
  mounted() {
    window.addEventListener('load', () => {
      this.computeHeight;
    });
  },
};
</script>
