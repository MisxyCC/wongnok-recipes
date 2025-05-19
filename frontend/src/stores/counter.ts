import { ref, computed } from 'vue';
import { defineStore } from 'pinia';
import type User from '@/models/User';

export const userStore = defineStore('user', {
  state: () =>
    ({
      uuid: '',
      name: '',
      isAuthenticated: false,
    }) as User,
});
