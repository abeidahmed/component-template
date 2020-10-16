<template>
  <div class="relative">
    <button @click="isActive = !isActive" class="text-sm font-medium text-gray-500 transition duration-150 ease-in-out sm:text-base hover:text-gray-800">Give your feedback</button>
    <div :class="{ 'hidden': !isActive }" class="absolute p-4 pb-0 mt-2 transform -translate-x-1/2 bg-white rounded-md shadow-lg w-80 left-1/2">
      <div class="flex items-center space-x-1" :class="activeState === 'success' ? 'justify-end' : 'justify-between'">
        <span aria-hidden="true" class="w-7" :class="{ 'hidden': activeState !== 'initial' }"></span>
        <button @click="activeState = 'initial'" class="p-1 rounded focus:outline-none focus:shadow-outline" :class="{ 'hidden': activeState !== 'feedback' }">
          <svg class="w-4 h-4 text-gray-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
          </svg>
        </button>
        <h3 class="text-sm font-semibold text-gray-500" :class="{ 'hidden': activeState === 'success' }">What's on your mind?</h3>
        <button @click="isActive = false" class="p-1 rounded focus:outline-none focus:shadow-outline">
          <svg class="w-4 h-4 text-gray-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
      </div>
      <div class="mt-3" :class="activeState === 'initial' ? 'block' : 'hidden'">
        <div class="h-28">
          <div class='flex items-center justify-between space-x-3'>
            <div class="w-1/3">
              <button @click="activeState = 'feedback'; activeTag = 'Issue'" type="button" class="flex flex-col items-center justify-center w-full p-3 text-gray-500 transition duration-150 ease-in-out rounded-md focus:outline-none focus:shadow-outline bg-gray-50 hover:bg-gray-100">
                <Alert />
                <span class="mt-2 text-sm text-gray-500">Issue</span>
              </button>
            </div>
            <div class="w-1/3">
              <button @click="activeState = 'feedback'; activeTag = 'Idea'" type="button" class="flex flex-col items-center justify-center w-full p-3 text-gray-500 transition duration-150 ease-in-out rounded-md focus:outline-none focus:shadow-outline bg-gray-50 hover:bg-gray-100">
                <Idea />
                <span class="mt-2 text-sm text-gray-500">Idea</span>
              </button>
            </div>
            <div class="w-1/3">
              <button @click="activeState = 'feedback'; activeTag = 'Other'" type="button" class="flex flex-col items-center justify-center w-full p-3 text-gray-500 transition duration-150 ease-in-out rounded-md focus:outline-none focus:shadow-outline bg-gray-50 hover:bg-gray-100">
                <svg class="w-12 h-12" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h.01M12 12h.01M19 12h.01M6 12a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0z" />
                </svg>
                <span class="mt-2 text-sm text-gray-500">Other</span>
              </button>
            </div>
          </div>
        </div>
      </div>
      <form @submit.prevent="handleSubmit" :class="activeState === 'feedback' ? 'block' : 'hidden'" class="mt-3 h-28">
        <div>
          <label for="feedback-content" class="sr-only">Type your feedback</label>
          <textarea v-model="content" id="feedback-content" rows="3" placeholder="Share your feedback" class="block w-full text-sm font-medium resize-none form-textarea"></textarea>
          <button class="w-full px-2 mt-1.5 py-0.5 text-sm font-medium leading-6 text-white transition duration-150 ease-in-out bg-indigo-600 rounded-md hover:bg-indigo-500 focus:outline-none focus:shadow-outline">Give feedback</button>
        </div>
      </form>
      <div :class="activeState === 'success' ? 'block' : 'hidden'" class="mt-3">
        <div class="pb-4 text-center h-28">
          <svg class="w-12 h-12 mx-auto text-green-400" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
          </svg>
          <h3 class="mt-3 text-sm font-medium text-gray-600">Yay! You just gave a feedback!</h3>
          <button @click="activeState = 'initial'" class="px-3 py-0.5 mt-1 text-xs leading-5 text-gray-500 bg-gray-100 rounded hover:text-gray-700 focus:outline-none border border-transparent focus:border-gray-300">Give more</button>
        </div>
      </div>
      <footer class="py-1.5 text-xs text-center text-gray-400">
        Widget by <a href="https://feeder-fish.herokuapp.com/" target="_blank" class="text-gray-500 underline">Feeder</a>
      </footer>
    </div>
  </div>
</template>

<script>
import Alert from './svg/icons/alert'
import Idea from './svg/icons/idea'

export default {
  components: {
    Alert,
    Idea
  },
  data() {
    return {
      isActive: true,
      activeState: 'initial',
      activeTag: '',
      content: '',
      projectId: '63171620-e6be-4201-8dff-06af6c9bdaf6',
    }
  },
  methods: {
    handleSubmit() {
      fetch(`https://feeder-fish.herokuapp.com/v1/projects/${this.projectId}/feedbacks?tag=${this.activeTag}`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          feedback: {
            content: this.content,
            sender_email: 'Guest',
            page_url: window.location.pathname,
            device: ''
          }
        }),
      })
      .then(res => this.activeState = 'success')
      .catch(err => console.log(err))
    }
  }
}
</script>