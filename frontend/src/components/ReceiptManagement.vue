<template>
  <div class="card flex flex-wrap justify-center items-center">
    <Dialog
      v-if="visible"
      v-model:visible="visible"
      modal
      header="เพิ่ม/แก้ไข ข้อมูลสูตรอาหาร"
      class="w-auto"
    >
      <div class="flex items-center gap-4 mb-4">
        <label for="foodName" class="font-semibold w-auto">ชื่ออาหาร</label>
        <InputText id="foodName" class="flex-auto" autocomplete="off" />
      </div>
      <div class="flex items-center gap-4 mb-8">
        <label for="foodPic" class="font-semibold w-auto">Link รุปภาพอาหาร</label>
        <InputText id="foodPic" class="flex-auto" autocomplete="off" />
      </div>
      <div class="flex items-center gap-4 mb-8">
        <label for="ingredient" class="font-semibold w-auto">วัตถุดิบ</label>
        <InputText id="ingredient" class="flex-auto" autocomplete="off" />
      </div>
      <div class="flex items-center gap-4 mb-8">
        <label for="step" class="font-semibold w-auto">ขั้นตอน</label>
        <InputText id="step" class="flex-auto" autocomplete="off" />
      </div>
      <div class="flex items-center gap-4 mb-8">
        <label for="period" class="font-semibold w-auto">ระยะเวลาทำอาหาร (นาที)</label>
        <Select v-model="selectedTimeUsed" :options="timeChoices" class="w-full md:w-56" />
      </div>
      <div class="flex items-center gap-4 mb-8">
        <label for="difficulty" class="font-semibold w-auto">ความยากง่ายของสูตร</label>
        <Select v-model="selectedDifficulty" :options="difficulties" class="w-full md:w-56" />
      </div>
      <div class="flex justify-center items-center gap-2 p-2">
        <Button type="button" label="บันทึกข้อมูล" @click="visible = false"></Button>
      </div>
    </Dialog>
  </div>
</template>
<script setup lang="ts">
import Dialog from 'primevue/dialog';
import { ref, type Ref } from 'vue';

const visible = defineModel<boolean>('visible');
const selectedTimeUsed: Ref<any> = ref(null);
const timeChoices = ref(['5-10', '11-30', '31-60', '60+']);
const selectedDifficulty: Ref<any> = ref(null);
const difficulties = ref(['Easy', 'Medium', 'Hard', 'Extremel Hard']);
</script>
