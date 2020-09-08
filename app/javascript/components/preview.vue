<template>
  <div class="mt-12 sm:px-6 lg:px-8">
    <div class="overflow-hidden border-t border-b border-gray-200 sm:border sm:rounded-lg">
      <div
        class="flex items-center justify-between px-4 py-2 bg-white border-b border-gray-200 sm:px-6 lg:px-8 sm:py-4 sm:items-baseline"
      >
        <div>
          <p class="text-base leading-snug truncate font-regular md:text-lg">{{ title }}</p>
        </div>
        <div class="items-center hidden sm:flex">
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
            <button
              class="inline-flex items-center justify-center text-gray-500 hover:text-gray-700"
              @click="copy"
            >
              <svg viewBox="0 0 20 20" fill="currentColor" class="w-5 h-5">
                <path d="M8 3a1 1 0 011-1h2a1 1 0 110 2H9a1 1 0 01-1-1z" />
                <path
                  d="M6 3a2 2 0 00-2 2v11a2 2 0 002 2h8a2 2 0 002-2V5a2 2 0 00-2-2 3 3 0 01-3 3H9a3 3 0 01-3-3z"
                />
              </svg>
            </button>
          </div>
        </div>
        <div class="sm:hidden">
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
      <div v-show="showCode">
        <Prism language="html">{{ partialCode }}</Prism>
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
      partialCode,
      full: { front_matter, content },
    } = this.template;
    return {
      title: front_matter.title,
      content,
      partialCode,
      frameHeight: '',
      showCode: false,
    };
  },
  methods: {
    copy() {
      const textarea = document.createElement('textarea');
      textarea.value = this.partialCode;
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
  created() {
    window.addEventListener('load', () => {
      this.computeHeight;
    });
  },
};
</script>
