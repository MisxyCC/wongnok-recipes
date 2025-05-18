<template>
  <div
    class="min-h-screen bg-gradient-to-br from-purple-600 to-teal-400 flex flex-col justify-center items-center p-4"
  >
    <div
      class="bg-white shadow-xl rounded-xl p-8 md:p-12 w-full max-w-md transform transition-all hover:scale-105 duration-300"
    >
      <div class="flex flex-col text-center mb-8">
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
            d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z"
          />
        </svg>
        <h1 class="mt-6 text-3xl font-extrabold text-gray-900">ยินดีต้อนรับ</h1>
      </div>

      <form @submit.prevent="handleSubmit" class="space-y-8">
        <div>
          <label for="username" class="block text-sm font-medium text-gray-700 mb-1">
            ชื่อผู้ใช้งาน
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
                  d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z"
                  clip-rule="evenodd"
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
            {{ isLoading ? 'กำลังเข้าสู่ระบบ..' : 'เข้าสู่ระบบ' }}
          </button>
        </div>
      </form>

      <p class="mt-8 text-center text-sm text-gray-600">
        ยังไม่มีบัญชีผู้ใช้?
        <RouterLink
          to="/register"
          class="font-medium text-purple-600 hover:text-purple-500 transition duration-150 ease-in-out"
          >สมัครสมาชิก</RouterLink
        >
      </p>
    </div>
  </div>
</template>

<script setup lang="ts">
import { emptyString } from '@/constants/GlobalConstants';
import { ref } from 'vue';
import { useRouter } from 'vue-router';

const username = ref<string>(emptyString);
const password = ref<string>(emptyString);
const isLoading = ref<boolean>(false);
const router = useRouter();
const handleSubmit = async () => {
  if (!username.value || !password.value) {
    alert('Please enter both username and password.');
    return;
  }

  isLoading.value = true;
  console.log('Attempting login with:', {
    username: username.value,
    password: password.value,
  });

  await new Promise((resolve) => setTimeout(resolve, 2000));

  isLoading.value = false;
  alert(
    `Login submitted!\nUsername: ${username.value}\nPassword: ${password.value}\n(This is a demo, no actual login occurred)`,
  );

  username.value = emptyString;
  password.value = emptyString;
  router.push('/');
};
</script>

<style scoped>
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
