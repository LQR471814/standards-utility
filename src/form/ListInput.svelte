<script lang="ts">
  import { cloneDeep } from "lodash";
  import { fly } from "svelte/transition";
  import { flip } from "svelte/animate";
  import { createEventDispatcher } from "svelte";
  import { classList, withoutElement } from "~/common/general";

  import Label from "~/form/Label.svelte";
  import { Icon } from "@steeze-ui/svelte-icon";
  import { Close, Menu, Add } from "@steeze-ui/remix-icons";

  type T = $$Generic;

  const dispatcher = createEventDispatcher<{ update: T[] }>();

  export let elements: T[] = [];
  export let newElement: () => T;
  export let presets: { [key: string]: T[] } | undefined = undefined;

  let showPresets = false;

  const clickable = classList(
    "w-6 h-6 transition-all",
    "hover:cursor-pointer hover:translate-y-[2px]",
    "active:translate-y-1"
  );
</script>

{#if showPresets && presets}
  <div class="py-2 px-4" in:fly={{ y: 10 }}>
    {#each Object.keys(presets) as k}
      <button
        on:click={() => {
          if (!presets) throw new Error("bad state");
          elements = cloneDeep(presets[k]);
          dispatcher("update", elements);
          showPresets = false;
        }}
      >
        <Label
          className={classList(
            "mb-2 hover:cursor-pointer hover:translate-y-[1px]",
            "active:translate-y-[2px] transition-all"
          )}
          preset="h3"
        >
          {k}
        </Label>
      </button>
    {/each}
  </div>
{:else}
  {#each elements as e, i (e)}
    <div
      class="flex items-center"
      in:fly={{ y: 10 }}
      animate:flip={{ duration: 300 }}
    >
      <slot {e} {i} />
      <button
        on:click={() => {
          elements = withoutElement(elements, i);
          dispatcher("update", elements);
        }}
      >
        <Icon src={Close} class={classList(clickable, "ml-4")} />
      </button>
    </div>
  {/each}
{/if}

<div
  class={classList("my-2 flex", presets ? "justify-between" : "justify-end")}
>
  {#if presets}
    <button on:click={() => (showPresets = !showPresets)}>
      <Icon src={Menu} class={clickable} />
    </button>
  {/if}
  <button
    on:click={() => {
      elements = [...elements, newElement()];
      dispatcher("update", elements);
    }}
  >
    <Icon src={Add} class={clickable} />
  </button>
</div>
