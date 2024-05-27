<script lang="ts">
  import { GlobalWorkerOptions } from "pdfjs-dist";
  import Home from "~/Home.svelte";
  import { tfjs } from "./globals";
  import { twMerge } from "tailwind-merge";
  import { fade } from "svelte/transition";
  import { state } from "./state";
  import { measureModelPB } from "./state/models";

  (async () => {
    GlobalWorkerOptions.workerSrc = "/workers/pdf.worker.js";

    $state.message = "loading modules...";
    const { loadGraphModel } = await tfjs;

    $state.message = "loading model...";
    const modelPB = await loadGraphModel(
      `${window.location.origin}/models/web_model/model.json`
    );
    measureModelPB.update(() => modelPB);

    $state.message = undefined;
  })();
</script>

<main>
  {#if $state.message}
    <div
      class={twMerge(
        "fixed top-0 left-0 w-[100vw] h-[100vh]",
        "backdrop-blur-md centered"
      )}
      transition:fade={{ duration: 150 }}
    >
      <h2 class="text-2xl italic font-semibold">
        {$state.message}
      </h2>
    </div>
  {/if}
  <Home />
</main>
