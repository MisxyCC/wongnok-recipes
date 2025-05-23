import './assets/main.css';
import { createApp } from 'vue';
import { createPinia } from 'pinia';
import PrimeVue from 'primevue/config';
import Aura from '@primeuix/themes/aura';
import App from './App.vue';
import router from './router';
import { userStore } from '@/stores/counter';
const app = createApp(App);
app.use(PrimeVue, {
  theme: {
    preset: Aura,
  },
});

app.use(createPinia());
app.use(router);

app.mount('#app');

export const userStoreInstance = userStore();
