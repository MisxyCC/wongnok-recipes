<template>
  <div class="card text-xl">
    <Menubar :model="items">
      <template #end>
        <div class="flex items-center px-2">
          <button
            @click="logout"
            class="p-0 m-0 border-none bg-transparent cursor-pointer focus:outline-none"
            aria-label="Logout"
          >
            <p class="text-green-700">
              {{ userStoreInstance.isAuthenticated ? 'ออกจากระบบ' : 'เข้าสู่ระบบ' }}
            </p>
          </button>
        </div>
      </template>
    </Menubar>
  </div>
</template>
<script setup lang="ts">
import { ref, type Ref } from 'vue';
import Menubar from 'primevue/menubar';
import { useRouter } from 'vue-router';
import { userStoreInstance } from '@/main';
const router = useRouter();
const items = ref([
  {
    label: 'Wongnok - วงนอก จำกัด มหาชน',
    icon: 'pi pi-home',
  },
]);



// Logout function
const logout = () => {
  console.log('Logout action triggered');
  userStoreInstance.isAuthenticated = false;
  // --- Implement your actual logout logic here ---
  // Examples:
  // 1. Clear authentication tokens (e.g., from localStorage or Vuex store)
  //    localStorage.removeItem('authToken');

  // 2. Call a backend API to invalidate the session
  //    fetch('/api/logout', { method: 'POST' })
  //      .then(response => {
  //        if (response.ok) {
  //          // Proceed to step 3
  //        }
  //      });

  // 3. Redirect to the login page (if using Vue Router)
  //    import { useRouter } from 'vue-router';
  //    const router = useRouter(); // Make sure this is setup if you use it inside logout
  //    router.push('/login');

  // For demonstration purposes:
  //alert('Logout functionality would be implemented here. Check the console.');
  router.push('/login');
  // --- End of actual logout logic placeholder ---
};
</script>
