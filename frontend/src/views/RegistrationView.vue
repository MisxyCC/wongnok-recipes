<template>
  <div
    class="min-h-screen bg-gradient-to-br from-purple-500 to-teal-400 flex flex-col justify-center items-center p-4"
  >
    <div
      class="bg-white shadow-xl rounded-xl p-8 md:p-12 w-full max-w-md transform transition-all hover:scale-105 duration-300"
    >
      <div class="flex flex-col items-center text-center mb-8">
        <svg
          class="mx-auto h-16 w-auto text-purple-600"
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          stroke-width="1.5"
          stroke="currentColor"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M19 7.5v3m0 0v3m0-3h3m-3 0h-3m-2.25-4.125a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zM4 19.235v-.11a6.375 6.375 0 0112.75 0v.109A12.318 12.318 0 0110.374 21c-2.331 0-4.512-.645-6.374-1.766z"
          />
        </svg>
        <h1 class="mt-6 text-3xl font-extrabold text-gray-900">สร้างบัญชีผู้ใช้</h1>
        <p class="mt-2 text-sm text-gray-600">มาร่วมรีวิวและเป็นส่วนหนึ่งของ Wongnok กัน!</p>
      </div>

      <form @submit.prevent="handleSubmit" class="space-y-7">
        <div>
          <label for="name" class="block text-sm font-medium text-gray-700 mb-1"
            >ชื่อ-นามสกุล</label
          >
          <div class="mt-1 relative rounded-md shadow-sm">
            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
              <svg
                class="h-5 w-5 text-gray-400"
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 20 20"
                fill="currentColor"
              >
                <path
                  fill-rule="evenodd"
                  d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-5.5-2.5a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0zM10 12a5.99 5.99 0 00-4.793 2.39A6.483 6.483 0 0010 16.5a6.483 6.483 0 004.793-2.11A5.99 5.99 0 0010 12z"
                  clip-rule="evenodd"
                />
              </svg>
            </div>
            <input
              id="name"
              name="name"
              type="text"
              v-model="name"
              required
              class="appearance-none block w-full px-3 py-3 pl-10 border border-gray-300 rounded-md placeholder-gray-400 focus:outline-none focus:ring-purple-500 focus:border-purple-500 sm:text-sm transition duration-150 ease-in-out"
              placeholder="ชื่อ-นามสกุล"
            />
          </div>
        </div>

        <div>
          <label for="username" class="block text-sm font-medium text-gray-700 mb-1">
            ชื่อผู้ใช้งาน
          </label>
          <div class="mt-1 relative rounded-md shadow-sm">
            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
              <svg
                class="h-5 w-5 text-gray-400"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke-width="1.5"
                stroke="currentColor"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z"
                />
              </svg>
            </div>
            <input
              id="username"
              name="username"
              type="text"
              v-model="username"
              required
              class="appearance-none block w-full px-3 py-3 pl-10 border border-gray-300 rounded-md placeholder-gray-400 focus:outline-none focus:ring-purple-500 focus:border-purple-500 sm:text-sm transition duration-150 ease-in-out"
              placeholder="ชื่อผู้ใช้งาน"
            />
          </div>
        </div>

        <div>
          <label for="password" class="block text-sm font-medium text-gray-700 mb-1">
            รหัสผ่าน
          </label>
          <div class="mt-1 relative rounded-md shadow-sm">
            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
              <svg
                class="h-5 w-5 text-gray-400"
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 20 20"
                fill="currentColor"
              >
                <path
                  fill-rule="evenodd"
                  d="M10 1a4.5 4.5 0 00-4.5 4.5V9H5a2 2 0 00-2 2v6a2 2 0 002 2h10a2 2 0 002-2v-6a2 2 0 00-2-2h-.5V5.5A4.5 4.5 0 0010 1zm3 8V5.5a3 3 0 10-6 0V9h6z"
                  clip-rule="evenodd"
                />
              </svg>
            </div>
            <input
              id="password"
              name="password"
              type="password"
              v-model="password"
              required
              autocomplete="new-password"
              class="appearance-none block w-full px-3 py-3 pl-10 border border-gray-300 rounded-md placeholder-gray-400 focus:outline-none focus:ring-purple-500 focus:border-purple-500 sm:text-sm transition duration-150 ease-in-out"
              placeholder="••••••••"
            />
          </div>
        </div>

        <div>
          <button
            type="submit"
            class="group relative w-full flex justify-center py-3 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-purple-600 hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500 transition duration-150 ease-in-out"
            :disabled="isLoading"
          >
            <span class="absolute left-0 inset-y-0 flex items-center pl-3">
              <svg
                class="h-5 w-5 text-purple-500 group-hover:text-purple-400 transition ease-in-out duration-150"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke-width="1.5"
                stroke="currentColor"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
                />
              </svg>
            </span>
            {{ isLoading ? 'กำลัลงทะเบียน..' : 'ลงทะเบียน' }}
          </button>
        </div>
      </form>

      <p class="mt-8 text-center text-sm text-gray-600">
        มีแอคเค้าท์อยู่แล้ว?
        <RouterLink
          to="/"
          class="font-medium text-purple-600 hover:text-purple-500 transition duration-150 ease-in-out"
          >เข้าสู่ระบบ</RouterLink
        >
      </p>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

const name = ref<string>('');
const username = ref<string>('');
const password = ref<string>('');
// const confirmPassword = ref<string>(''); // Uncomment if using confirm password field
const isLoading = ref<boolean>(false);

const handleSubmit = async () => {
  if (!name.value || !username.value || !password.value) {
    alert('Please fill in all fields.');
    return;
  }
  // Uncomment and implement if using confirm password
  /*
  if (password.value !== confirmPassword.value) {
    alert('Passwords do not match.');
    return;
  }
  */

  isLoading.value = true;
  console.log('Attempting registration with:', {
    name: name.value,
    username: username.value,
    password: password.value, // In a real app, never log passwords directly
  });

  // Simulate API call
  await new Promise((resolve) => setTimeout(resolve, 2000));

  isLoading.value = false;
  alert(
    `Registration successful for ${name.value}!\nUsername: ${username.value}\n(This is a demo, no actual registration occurred)`,
  );

  // Clear form after submission for this demo
  name.value = '';
  username.value = '';
  password.value = '';
  // confirmPassword.value = ''; // Uncomment if using confirm password field
};
</script>

<style scoped>
/* Scoped styles can be added here if needed */
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.bg-white {
  animation: fadeIn 0.5s ease-out;
}
</style>
