<script lang="ts">
  import { Information } from "@steeze-ui/remix-icons";
  import { Icon } from "@steeze-ui/svelte-icon";
  import { createEventDispatcher } from "svelte";
  import { slide } from "svelte/transition";
  import { classList } from "~/common/general";

  const dispatcher = createEventDispatcher<{ input: string }>();

  export let value = "";
  export let className = "";
  export let placeholder: string | null = null;
  export let error: string | null = null;
  export let limitNumbers = false;
  export let disabled: boolean | undefined = undefined;
</script>

<div>
  <input
    type="text"
    {placeholder}
    {disabled}
    bind:value
    on:input={() => {
      if (limitNumbers) {
        const parsed = parseInt(value);
        if (isNaN(parsed) && value.length > 0) {
          value = value.replaceAll(/[^0-9]/gm, "");
          return;
        }
        if (!isNaN(parsed)) {
          value = parsed.toString();
        }
      }
      dispatcher("input", value);
    }}
    class={classList(
      "bg-transparent rounded-sm text-slate-900 outline-none w-[180px]",
      className
    )}
  />

  {#if error}
    <div transition:slide|local class="flex items-center">
      <Icon src={Information} class="w-4 h-4 fill-red-500 mr-1" />
      <p class="text-red-500 mb-1">{error}</p>
    </div>
  {/if}
</div>
