<!-- <template>
  <div class="flex flex-wrap flex-col md:flex-row"></div>
  <Card v-if="visible" v-model:visible="visible">
    <template #title>Simple Card</template>
    <template #content>
      <p class="m-0">
        Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore sed consequuntur error
        repudiandae numquam deserunt quisquam repellat libero asperiores earum nam nobis, culpa
        ratione quam perferendis esse, cupiditate neque quas!
      </p>
    </template>
  </Card>
</template>

<script setup lang="ts">
const visible = defineModel<boolean>('visible');
</script> -->

<template>
    <Dialog
      v-if="visible"
      v-model:visible="visible"
      modal
      header="ดูคะแนนรีวิว"
      class="w-md overflow-auto"
    >
     <div class="flex gap-4 p-2" v-for="index in 5" :key="index">
      <Card v-if="visible" v-model:visible="visible">
        <template #title>Simple Card</template>
        <template #content>
          <p class="m-0">
            Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore sed consequuntur
            error repudiandae numquam deserunt quisquam repellat libero asperiores earum nam nobis,
            culpa ratione quam perferendis esse, cupiditate neque quas!
          </p>
        </template>
      </Card>
     </div>
    </Dialog>
</template>

<script setup lang="ts">
import { ref, type Ref } from 'vue';

const visible = defineModel<boolean>('visible');
const allCards: Ref<number> = ref(5);
</script>
