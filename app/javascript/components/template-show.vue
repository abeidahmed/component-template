<template>
  <div class="flex flex-col bg-gray-200">
    <header v-show="showHeader" class="relative bg-gray-800">
      <div class="flex items-center justify-between px-4 py-4 sm:px-6 md:px-6 lg:px-8 xl:px-12">
        <div class="min-w-0">
          <h1 class="text-sm font-medium leading-5 text-gray-200 truncate md:text-base">{{ title }}</h1>
        </div>
        <div
          class="absolute hidden sm:flex sm:items-center sm:space-x-4"
          style="transform: translateX(-50%); left: 50%"
        >
          <button
            aria-label="mobile size"
            class="items-center justify-center hidden p-2 transition duration-150 ease-in-out rounded-md sm:flex focus:outline-none focus:bg-gray-700"
            :class="activeScreen === 'smartphone' ? 'text-red-500' : 'text-gray-400 focus:text-white hover:text-white'"
            @click="frameWidth = '411px'"
          >
            <svg class="w-6 h-6" viewBox="0 0 24 24" fill="none">
              <path
                d="M17 2H7C5.89543 2 5 2.89543 5 4V20C5 21.1046 5.89543 22 7 22H17C18.1046 22 19 21.1046 19 20V4C19 2.89543 18.1046 2 17 2Z"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
              <path
                d="M12 18H12.01"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
              <path
                fill-rule="evenodd"
                clip-rule="evenodd"
                d="M17 5C17 5.55228 16.5523 6 16 6H8C7.44772 6 7 5.55228 7 5V5C7 4.44772 7.44772 4 8 4H16C16.5523 4 17 4.44772 17 5V5Z"
                fill="currentColor"
              />
            </svg>
          </button>
          <button
            aria-label="tablet size"
            class="items-center justify-center hidden p-2 transition duration-150 ease-in-out rounded-md focus:outline-none focus:bg-gray-700 sm:flex"
            :class="activeScreen === 'tablet' ? 'text-red-500' : 'text-gray-400 focus:text-white hover:text-white'"
            @click="frameWidth = calcMaxFrameWidth(640, 1023) + 'px'"
          >
            <svg class="w-6 h-6" viewBox="0 0 24 24" fill="none">
              <path
                d="M18 2H6C4.89543 2 4 2.89543 4 4V20C4 21.1046 4.89543 22 6 22H18C19.1046 22 20 21.1046 20 20V4C20 2.89543 19.1046 2 18 2Z"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
              <path
                d="M12 18H12.01"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
            </svg>
          </button>
          <button
            aria-label="laptop size"
            class="items-center justify-center hidden p-2 transition duration-150 ease-in-out rounded-md focus:outline-none focus:bg-gray-700 lg:flex"
            :class="activeScreen === 'laptop' ? 'text-red-500' : 'text-gray-400 focus:text-white hover:text-white'"
            @click="frameWidth = calcMaxFrameWidth(1024, 1279) + 'px'"
          >
            <svg class="w-6 h-6" viewBox="0 0 24 24" fill="none">
              <path
                d="M20 4H4C2.89543 4 2 4.89543 2 6V16C2 17.1046 2.89543 18 4 18H20C21.1046 18 22 17.1046 22 16V6C22 4.89543 21.1046 4 20 4Z"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
              <path
                d="M1 20L23 20"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
            </svg>
          </button>
          <button
            aria-label="desktop size"
            class="items-center justify-center hidden p-2 transition duration-150 ease-in-out rounded-md focus:outline-none focus:bg-gray-700 xl:flex"
            :class="activeScreen === 'desktop' ? 'text-red-500' : 'text-gray-400 focus:text-white hover:text-white'"
            @click="frameWidth = '100%'"
          >
            <svg class="w-6 h-6" viewBox="0 0 24 24" fill="none">
              <path
                d="M20 3H4C2.89543 3 2 3.89543 2 5V15C2 16.1046 2.89543 17 4 17H20C21.1046 17 22 16.1046 22 15V5C22 3.89543 21.1046 3 20 3Z"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
              <path
                d="M8 21H16"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
              <path
                d="M12 17V21"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
              />
            </svg>
          </button>
        </div>

        <button
          aria-label="hide header"
          class="items-center justify-center p-2 text-gray-400 transition duration-150 ease-in-out rounded-md focus:text-white focus:outline-none focus:bg-gray-700 hover:text-white"
          @click="showHeader = false"
        >
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M5 15l7-7 7 7"
            />
          </svg>
        </button>
      </div>
    </header>
    <div class="absolute top-0 right-0 p-6" :class="{ hidden: showHeader }">
      <button
        aria-label="show header"
        class="items-center justify-center p-2 text-gray-700 transition duration-150 ease-in-out rounded-md focus:text-gray-800 focus:outline-none focus:bg-gray-300 hover:text-gray-800"
        @click="showHeader = true"
      >
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
        </svg>
      </button>
    </div>
    <iframe
      ref="iframeFull"
      :srcdoc="srcDoc"
      class="w-full h-screen mx-auto"
      :style="{ maxWidth: frameWidth }"
    ></iframe>
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
    const { htmlContent, cssPath, title } = this.template;
    return {
      srcDoc: `
        <!DOCTYPE html>
        <html lang="en">
          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link rel="stylesheet" href="${cssPath}"/>
          </head>
          <body>
            ${htmlContent.content}
          </body>
        </html>
      `,
      title,
      frameWinWidth: 0,
      activeScreen: '',
      frameWidth: '',
      showHeader: true,
      browserWidth: 0,
    };
  },
  watch: {
    frameWinWidth() {
      if (this.frameWinWidth >= 0 && this.frameWinWidth <= 639) {
        this.activeScreen = 'smartphone';
      } else if (this.frameWinWidth >= 640 && this.frameWinWidth <= 1023) {
        this.activeScreen = 'tablet';
      } else if (this.frameWinWidth >= 1024 && this.frameWinWidth <= 1279) {
        this.activeScreen = 'laptop';
      } else if (this.frameWinWidth >= 1280) {
        this.activeScreen = 'desktop';
      }
    },
  },
  mounted() {
    this.$refs.iframeFull.contentWindow.addEventListener(
      'resize',
      this.handleResize
    );
    this.handleResize();
    window.addEventListener('resize', this.handleBrowserResize);
    this.handleBrowserResize();
  },
  destroyed() {
    this.$refs.iframeFull.contentWindow.removeEventListener(
      'resize',
      this.handleResize
    );
    window.removeEventListener('resize', this.handleBrowserResize);
  },
  methods: {
    handleResize() {
      this.frameWinWidth = this.$refs.iframeFull.contentWindow.document.body.offsetWidth;
    },
    handleBrowserResize() {
      this.browserWidth = window.innerWidth;
    },
    calcMaxFrameWidth(start, end) {
      if (this.browserWidth >= start && this.browserWidth <= end) {
        return end;
      }
      return start;
    },
  },
};
</script>