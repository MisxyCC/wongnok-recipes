<template>
  <div class="card">
    <Menubar :model="items">
      <template #item="{ item, props, hasSubmenu, root }">
        <a v-ripple class="flex items-center" v-bind="props.action">
          <span>{{ item.label }}</span>
          <Badge
            v-if="item.badge"
            :class="{ 'ml-auto': !root, 'ml-2': root }"
            :value="item.badge"
          />
          <span
            v-if="item.shortcut"
            class="ml-auto border border-surface rounded bg-emphasis text-muted-color text-xs p-1"
            >{{ item.shortcut }}</span
          >
          <i
            v-if="hasSubmenu"
            :class="[
              'pi pi-angle-down ml-auto',
              { 'pi-angle-down': root, 'pi-angle-right': !root },
            ]"
          ></i>
        </a>
      </template>
      <template #end>
        <div class="flex items-center gap-2">
          <p>ออกจากระบบ</p>
          <button
            @click="logout"
            class="p-0 m-0 border-none bg-transparent cursor-pointer focus:outline-none"
            aria-label="Logout"
          >
            <i class="pi pi-sign-out" style="font-size: 2rem"></i>
          </button>
        </div>
      </template>
    </Menubar>
  </div>
</template>
<script setup lang="ts">
import { ref } from 'vue';
import Menubar from 'primevue/menubar';
import Badge from 'primevue/badge'; // Import Badge if not globally registered and needed by Menubar items
import { useRouter } from 'vue-router';

const router = useRouter();
const items = ref([
  {
    label: 'หน้าหลัก',
    icon: 'pi pi-home',
  },
  {
    label: 'Projects',
    icon: 'pi pi-search',
    badge: 3,
    items: [
      {
        label: 'Core',
        icon: 'pi pi-bolt',
        shortcut: '⌘+S',
      },
      {
        label: 'Blocks',
        icon: 'pi pi-server',
        shortcut: '⌘+B',
      },
      {
        separator: true,
      },
      {
        label: 'UI Kit',
        icon: 'pi pi-pencil',
        shortcut: '⌘+U',
      },
    ],
  },
]);

// Logout function
const logout = () => {
  console.log('Logout action triggered');
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
