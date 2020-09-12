<template>
  <div class="flex flex-col bg-gray-200">
    <header v-if="goBackURL" v-show="showHeader" class="relative flex-shrink-0 bg-gray-800">
      <div class="flex items-center justify-between h-16 px-4 sm:px-6 md:px-6 lg:px-8 xl:px-12">
        <div class="min-w-0">
          <a :href="goBackURL" class="flex items-center group">
            <IconBase
              viewBox="0 0 20 20"
              modifier="solid"
              class="w-5 h-5 -ml-2 text-gray-200 transition duration-150 ease-in-out group-hover:text-gray-400"
            >
              <ChevronLeft />
            </IconBase>
            <h1
              class="pl-1 text-sm font-medium leading-5 text-gray-200 truncate transition duration-150 ease-in-out md:text-base group-hover:text-gray-400"
            >{{ title }}</h1>
          </a>
        </div>
        <div
          class="absolute hidden sm:flex sm:items-center sm:space-x-4"
          style="transform: translateX(-50%); left: 50%"
        >
          <div class="is-tooltip">
            <button
              aria-label="mobile size"
              class="items-center justify-center hidden p-2 transition duration-150 ease-in-out rounded-md sm:flex focus:outline-none focus:bg-gray-700"
              :class="activeScreen === 'smartphone' ? 'text-red-500' : 'text-gray-400 focus:text-white hover:text-white'"
              @click="frameWidth = '411px'"
            >
              <IconBase class="w-6 h-6" viewBox="0 0 24 24" modifier="stroke">
                <MobileScreen />
              </IconBase>
            </button>
            <span class="tooltip-text is-bottom">Mobile view</span>
          </div>
          <div class="is-tooltip">
            <button
              aria-label="tablet size"
              class="items-center justify-center hidden p-2 transition duration-150 ease-in-out rounded-md focus:outline-none focus:bg-gray-700 sm:flex"
              :class="activeScreen === 'tablet' ? 'text-red-500' : 'text-gray-400 focus:text-white hover:text-white'"
              @click="frameWidth = calcMaxFrameWidth(640, 1023) + 'px'"
            >
              <IconBase class="w-6 h-6" modifier="stroke" viewBox="0 0 24 24">
                <TabletScreen />
              </IconBase>
            </button>
            <span class="tooltip-text is-bottom">Tablet view</span>
          </div>
          <div class="is-tooltip">
            <button
              aria-label="laptop size"
              class="items-center justify-center hidden p-2 transition duration-150 ease-in-out rounded-md focus:outline-none focus:bg-gray-700 lg:flex"
              :class="activeScreen === 'laptop' ? 'text-red-500' : 'text-gray-400 focus:text-white hover:text-white'"
              @click="frameWidth = calcMaxFrameWidth(1024, 1279) + 'px'"
            >
              <IconBase class="w-6 h-6" viewBox="0 0 24 24" modifier="stroke">
                <LaptopScreen />
              </IconBase>
            </button>
            <span class="tooltip-text is-bottom">Laptop view</span>
          </div>
          <div class="is-tooltip">
            <button
              aria-label="desktop size"
              class="items-center justify-center hidden p-2 transition duration-150 ease-in-out rounded-md focus:outline-none focus:bg-gray-700 xl:flex"
              :class="activeScreen === 'desktop' ? 'text-red-500' : 'text-gray-400 focus:text-white hover:text-white'"
              @click="frameWidth = '100%'"
            >
              <IconBase class="w-6 h-6" viewBox="0 0 24 24" modifier="stroke">
                <Desktop />
              </IconBase>
            </button>
            <span class="tooltip-text is-bottom">Desktop view</span>
          </div>
        </div>

        <div class="is-tooltip">
          <button
            aria-label="hide header"
            class="items-center justify-center p-2 -mr-3 text-gray-400 transition duration-150 ease-in-out rounded-md focus:text-white focus:outline-none focus:bg-gray-700 hover:text-white"
            @click="showHeader = false, headerHeight = 0"
          >
            <IconBase class="w-6 h-6" viewBox="0 0 20 20" modifier="solid">
              <ChevronUp />
            </IconBase>
          </button>
          <span class="tooltip-text is-bottom">Hide header</span>
        </div>
      </div>
    </header>

    <div v-if="goBackURL" class="absolute top-0 right-0 z-50 p-1" :class="{ hidden: showHeader }">
      <button
        aria-label="show header"
        class="items-center justify-center text-white transition duration-150 ease-in-out bg-indigo-600 rounded shadow-md focus:text-gray-100 focus:outline-none focus:bg-indigo-400 hover:bg-indigo-400 hover:text-gray-100"
        @click="showHeader = true, headerHeight = '64px'"
      >
        <IconBase class="w-6 h-6" viewBox="0 0 20 20" modifier="solid">
          <ChevronDown />
        </IconBase>
      </button>
    </div>
    <iframe
      ref="iframeFull"
      :srcdoc="srcDoc"
      class="flex-1 w-full mx-auto"
      :style="{ maxWidth: frameWidth, height: goBackURL ? `calc(100vh - ${headerHeight})` : '100vh' }"
    ></iframe>
  </div>
</template>

<script>
import IconBase from './svg/icon-base';
import ChevronLeft from './svg/icons/chevron-left-solid';
import ChevronUp from './svg/icons/chevron-up';
import ChevronDown from './svg/icons/chevron-down';
import MobileScreen from './svg/icons/mobile-screen';
import TabletScreen from './svg/icons/tablet-screen';
import LaptopScreen from './svg/icons/laptop-screen';
import Desktop from './svg/icons/desktop-screen';

export default {
  components: {
    IconBase,
    ChevronLeft,
    ChevronUp,
    ChevronDown,
    MobileScreen,
    TabletScreen,
    LaptopScreen,
    Desktop,
  },
  props: {
    template: {
      type: Object,
      required: true,
    },
  },
  data() {
    const {
      contents: { htmlBody, title },
      cssPath,
      goBackURL,
    } = this.template;
    return {
      title,
      goBackURL,
      srcDoc: `
        <!DOCTYPE html>
        <html lang="en">
          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link rel="stylesheet" href="https://rsms.me/inter/inter.css">
            <link rel="stylesheet" href="${cssPath}"/>
          </head>
          <body>
            ${htmlBody}
          </body>
        </html>
      `,
      frameWinWidth: 0,
      activeScreen: '',
      frameWidth: '',
      showHeader: true,
      browserWidth: 0,
      frameScrollbarWidth: 0,
      headerHeight: '64px',
    };
  },
  watch: {
    frameWinWidth() {
      if (this.frameWinWidth >= 0 && this.frameWinWidth <= 639.99) {
        this.activeScreen = 'smartphone';
      } else if (this.frameWinWidth >= 640 && this.frameWinWidth <= 1023.99) {
        this.activeScreen = 'tablet';
      } else if (this.frameWinWidth >= 1024 && this.frameWinWidth <= 1279.99) {
        this.activeScreen = 'laptop';
      } else {
        this.activeScreen = 'desktop';
      }
    },
    showHeader() {
      if (this.showHeader) {
        this.headerHeight = '64px';
      } else {
        this.headerHeight = '0px';
      }
    },
  },
  mounted() {
    const frameWindow = this.$refs.iframeFull.contentWindow;
    frameWindow.addEventListener('load', this.calcFrameScrollbarWidth);
    frameWindow.addEventListener('resize', this.handleResize);
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
    calcFrameScrollbarWidth() {
      const frame = this.$refs.iframeFull.contentDocument;
      this.frameScrollbarWidth =
        document.body.offsetWidth - frame.body.offsetWidth;
    },
    handleResize() {
      this.frameWinWidth =
        this.$refs.iframeFull.contentWindow.document.body.offsetWidth +
        this.frameScrollbarWidth;
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