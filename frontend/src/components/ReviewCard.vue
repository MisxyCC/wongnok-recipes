<template>
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
</script>
