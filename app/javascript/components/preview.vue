<template>
  <div class="mt-12 sm:px-6 lg:px-8">
    <div class="border-t border-b border-gray-200 sm:border sm:rounded-lg">
      <div
        class="flex items-center justify-between min-w-0 px-4 py-2 bg-white border-b border-gray-200 rounded-t-lg md:px-6 md:py-4"
      >
        <div class="pr-2 truncate">
          <p class="text-base leading-snug truncate font-regular lg:text-lg">{{ title }}</p>
        </div>
        <div class="items-center hidden md:flex">
          <div class="flex items-center">
            <button
              class="inline-block px-3 py-2 ml-2 font-medium leading-none rounded-lg focus:outline-none hover:text-indigo-600 focus:text-indigo-600"
              :class="
                !showCode ? 'text-indigo-700 bg-indigo-100' : 'text-gray-500'
              "
              @click="showCode = false"
            >Preview</button>
            <button
              class="inline-block px-3 py-2 ml-2 font-medium leading-none rounded-lg focus:outline-none hover:text-indigo-600 focus:text-indigo-600"
              :class="
                showCode ? 'text-indigo-700 bg-indigo-100' : 'text-gray-500'
              "
              @click="showCode = true"
            >Code</button>
          </div>
          <div ref="clipboard" class="flex items-center">
            <div class="self-stretch pl-3 pr-4">
              <div class="h-full border-l border-gray-200"></div>
            </div>
            <div class="flex items-center space-x-4">
              <div class="is-tooltip">
                <a
                  :href="templateURL"
                  class="hidden text-gray-500 md:block hover:text-gray-700"
                  target="_blank"
                  aria-label="open in a new tab"
                >
                  <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                    <path
                      d="M11 3a1 1 0 100 2h2.586l-6.293 6.293a1 1 0 101.414 1.414L15 6.414V9a1 1 0 102 0V4a1 1 0 00-1-1h-5z"
                    />
                    <path
                      d="M5 5a2 2 0 00-2 2v8a2 2 0 002 2h8a2 2 0 002-2v-3a1 1 0 10-2 0v3H5V7h3a1 1 0 000-2H5z"
                    />
                  </svg>
                </a>
                <span class="tooltip-text is-top">View full screen</span>
              </div>
              <div class="inline-flex items-center justify-center is-tooltip">
                <button
                  class="inline-flex items-center justify-center text-gray-500 hover:text-gray-700"
                  aria-label="copy code snippet"
                  @click="copy"
                >
                  <svg viewBox="0 0 20 20" fill="currentColor" class="w-5 h-5">
                    <path d="M8 3a1 1 0 011-1h2a1 1 0 110 2H9a1 1 0 01-1-1z" />
                    <path
                      d="M6 3a2 2 0 00-2 2v11a2 2 0 002 2h8a2 2 0 002-2V5a2 2 0 00-2-2 3 3 0 01-3 3H9a3 3 0 01-3-3z"
                    />
                  </svg>
                </button>
                <span class="tooltip-text is-top">Copy code</span>
              </div>
            </div>
          </div>
        </div>
        <div class="md:hidden">
          <button
            class="inline-block px-3 py-3 font-medium leading-none rounded-lg focus:outline-none"
            @click="showCode = !showCode"
            :class="showCode ? 'bg-indigo-50 text-indigo-700' : 'text-gray-500'"
          >
            <svg viewBox="0 0 20 20" fill="currentColor" class="w-5 h-5">
              <path
                fill-rule="evenodd"
                d="M12.316 3.051a1 1 0 01.633 1.265l-4 12a1 1 0 11-1.898-.632l4-12a1 1 0 011.265-.633zM5.707 6.293a1 1 0 010 1.414L3.414 10l2.293 2.293a1 1 0 11-1.414 1.414l-3-3a1 1 0 010-1.414l3-3a1 1 0 011.414 0zm8.586 0a1 1 0 011.414 0l3 3a1 1 0 010 1.414l-3 3a1 1 0 11-1.414-1.414L16.586 10l-2.293-2.293a1 1 0 010-1.414z"
                clip-rule="evenodd"
              />
            </svg>
          </button>
        </div>
      </div>
      <div v-show="!showCode" class="overflow-hidden bg-gray-500 sm:rounded-b-lg">
        <div class="flex resizer" style="touch-action: none">
          <div class="flex-1">
            <iframe
              ref="iframe"
              frameborder="0"
              class="w-full"
              :srcdoc="srcdoc"
              :style="{ height: frameHeight }"
            ></iframe>
          </div>
          <div
            class="relative flex-shrink-0 hidden w-4 bg-gray-100 border-l md:block resizer-right cursor-ew-resize"
          >
            <div class="absolute inset-y-0 flex items-center">
              <svg
                class="w-4 h-4 text-gray-700 transform rotate-90"
                viewBox="0 0 20 20"
                fill="currentColor"
              >
                <path
                  fill-rule="evenodd"
                  d="M3 7a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 13a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"
                  clip-rule="evenodd"
                />
              </svg>
            </div>
          </div>
        </div>
      </div>
      <div v-show="showCode" class="overflow-hidden sm:rounded-b-lg">
        <Prism language="html">{{ displayCode }}</Prism>
      </div>
    </div>
  </div>
</template>

<script>
import Prism from 'vue-prism-component';

export default {
  props: {
    template: {
      type: Object,
      required: true,
    },
  },
  components: {
    Prism,
  },
  data() {
    const {
      displayCode,
      cssPath,
      title,
      htmlBody,
      templateURL,
    } = this.template;
    return {
      title,
      displayCode,
      templateURL,
      srcdoc: `
        <!DOCTYPE html>
        <html lang="en">
          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link rel="stylesheet" href="${cssPath}"/>
          </head>
          <body>
            ${htmlBody.content}
          </body>
        </html>
      `,
      frameHeight: '',
      showCode: false,
    };
  },
  mounted() {
    const frame = this.$refs.iframe.contentWindow;
    frame.addEventListener('load', this.calcFrameHeight);
    frame.addEventListener('resize', this.calcFrameHeight);
    this.calcFrameHeight();
  },
  methods: {
    copy() {
      const textarea = document.createElement('textarea');
      textarea.value = this.displayCode;
      textarea.style.position = 'fixed';
      textarea.style.left = '-9999999px';
      this.$refs.clipboard.append(textarea);
      textarea.focus();
      textarea.select();
      document.execCommand('copy');
      this.$refs.clipboard.removeChild(textarea);
    },
    calcFrameHeight() {
      this.frameHeight =
        this.$refs.iframe.contentDocument.body.offsetHeight + 'px';
    },
  },
};
</script>
