<template>
  <div
    class="min-h-screen bg-gradient-to-br from-purple-500 to-teal-400 flex flex-col justify-center items-center text-center p-6 selection:bg-indigo-200"
  >
    <div
      class="bg-white shadow-2xl rounded-xl p-8 md:p-16 w-full max-w-lg transform transition-all duration-300"
    >
      
      <h1 class="text-7xl md:text-9xl font-extrabold text-indigo-600 tracking-tighter">404</h1>
      <h2 class="mt-4 text-3xl md:text-4xl font-bold text-gray-800">Page Not Found</h2>
      <p class="mt-4 text-md md:text-lg text-gray-600 leading-relaxed">
        โอ๊ะ! ดูเหมือนว่าไม่พบหน้าที่คุณกำลังมองหา ซึ่งอาจไม่มีอยู่อีกต่อไป ถูกลบไปแล้ว หรือคุณอาจพิมพ์ URL ไม่ถูกต้อง
      </p>
      <div class="mt-10">
        <router-link
          to="/"
          class="inline-flex items-center px-8 py-3 text-lg font-semibold text-white bg-indigo-600 rounded-lg shadow-lg hover:bg-indigo-700 focus:outline-none focus:ring-4 focus:ring-indigo-300 transition-all duration-150 ease-in-out transform hover:scale-105"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            stroke-width="1.5"
            stroke="currentColor"
            class="w-5 h-5 mr-2"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              d="M2.25 12l8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h7.5"
            />
          </svg>
          กลับหน้าหลัก
        </router-link>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
// Using <router-link> directly, so no specific script logic needed for navigation.
// If you were to programmatically navigate, you might use:
// import { useRouter } from 'vue-router';
// const router = useRouter();
// const goToHome = () => {
//   router.push('/');
// };

// The current date for the footer is handled directly in the template.
</script>

<style scoped>
/* You can add custom styles here if needed, but Tailwind handles most of it. */
/* Example of a subtle animation for the 404 text if desired */
.tracking-tighter {
  animation: slight-pulse 2s infinite alternate ease-in-out;
}

@keyframes slight-pulse {
  0% {
    transform: scale(1);
    opacity: 0.9;
  }
  100% {
    transform: scale(1.02);
    opacity: 1;
  }
}

/* Adding selection color for better UX */
::selection {
  background-color: #c7d2fe; /* Tailwind's indigo-200 */
  color: #3730a3; /* Tailwind's indigo-800 */
}
::-moz-selection {
  /* Firefox */
  background-color: #c7d2fe;
  color: #3730a3;
}
</style>
