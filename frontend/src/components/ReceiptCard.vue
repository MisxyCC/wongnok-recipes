<template>
  <div class="my-custom-card-wrapper">
    <Card class="w-md overflow-hidden h-auto">
      <template #header>
        <img
          alt="user header"
          src="https://img.wongnai.com/p/1920x0/2017/06/15/fd84aa9604e44d63b36275b9b3320771.jpg"
          class="w-full"
        />
      </template>
      <template #title>
        <p>Advanced Card</p>
      </template>
      <template #subtitle>
        <span>
            เจ้าของสูตรอาหาร
            <Badge value="นาย s" severity="success"></Badge>
        </span>
      </template>
      <template #content>
        <p class="text-red-500 text-xl">วัตถุดิบ: xxxx</p>
        <p class="text-xl">ขั้นตอน: xxxx</p>
        <p class="text-xl">ระยะเวลา: xxxx</p>
        <p class="text-xl">ความยากง่ายของสูตรอาหาร: xxxx</p>
      </template>
      <template #footer>
        <div class="flex flex-col md:flex-row gap-3 mt-1">
          <Button label="ดูคะแนนรีวิว" class="w-full" />
          <Button v-if="userStoreInstance.isAuthenticated" label="แก้ไขรายการ" severity="info" class="w-full" @click="isReceiptManagementShown = true"/>
          <Button v-if="userStoreInstance.isAuthenticated" label="ลบรายการ" severity="danger" outlined class="w-full" />
        </div>
      </template>
    </Card>
  </div>
  <ReceiptManagement v-model:visible="isReceiptManagementShown"></ReceiptManagement>
</template>

<script setup lang="ts">
import { userStoreInstance } from '@/main';
import Badge from 'primevue/badge';
import { ref, type Ref } from 'vue';
const isReceiptManagementShown: Ref<boolean> = ref(false);
function isAuthenticated() {
  return userStoreInstance.isAuthenticated;
}
</script>

<style scoped>

</style>
