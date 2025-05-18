<template>
  <div class="w-screen">
    <NavMenu></NavMenu>
  <div class="card flex flex-col md:flex-row justify-center items-center min-w-screen p-3 gap-2">
    <Button
      label="เพิ่มข้อมูลสูตรอาหาร"
      icon="pi pi-plus"
      iconPos="left"
      @click="isReceiptManagementShown = true"
    />
    <p class="text-xl">ค้นหาสูตรอาหารด้วยชื่ออาหาร:</p>
    <AutoComplete v-model="value" :suggestions="items" @complete="search" input-class="w-auto" />
    <p class="text-xl">ค้นหาสูตรอาหารด้วยตามระดับเรตติ้ง:</p>
    <Select v-model="selectedRating" :options="ratings" class="w-full md:w-56" showClear />
    <Button label="ค้นหา" icon="pi pi-search" iconPos="left" />
  </div>
  <div class="flex flex-wrap gap-4 md:flex-row justify-center items-center p-3 gap-2">
    <ReceiptCard></ReceiptCard>
    <ReceiptCard></ReceiptCard>
    <ReceiptCard></ReceiptCard>
    <ReceiptCard></ReceiptCard>
    <ReceiptCard></ReceiptCard>
  </div>
  <ReceiptManagement v-model:visible="isReceiptManagementShown"></ReceiptManagement>
  </div>
</template>
<script setup lang="ts">
import NavMenu from '@/components/NavMenu.vue';
import ReceiptCard from '@/components/ReceiptCard.vue';
import ReceiptManagement from '@/components/ReceiptManagement.vue';
import AutoComplete from 'primevue/autocomplete';
import { ref, watchEffect, type Ref } from 'vue';
const isReceiptManagementShown: Ref<boolean> = ref(false);
const value = ref(null);
const items: Ref<string[]> = ref([]);
const selectedRating: Ref<any> = ref(null);
const ratings = ref(['1', '2', '3', '4', '5']);
const search = (event: any) => {
  items.value = [...Array(10).keys()].map((item) => event.query + '-' + item);
};
watchEffect(() => {
  console.log('selectedRating: ', selectedRating.value);
});
</script>
