<script lang="ts">
  import { createEventDispatcher } from "svelte";
  import { fly } from "svelte/transition";
  import { classList, debounce, styleList } from "~/common/general";

  import { Restart, ThumbDown, ThumbUp } from "@steeze-ui/remix-icons";
  import { Icon } from "@steeze-ui/svelte-icon";

  const dispatcher = createEventDispatcher<{ drop: void }>();
  const onclick = debounce(() => {
    dispatcher("drop");
  });

  export let mode: "up" | "down" | "reset";

  let hovered = false;

  $: translateBy = hovered ? "140%" : "120%";
  $: direction = mode === "down" || mode === "reset" ? "down" : "up";
</script>

<div
  class={classList(
    "absolute top-0 left-0 w-full h-full -translate-x-1/2",
    "flex justify-center transition-all"
  )}
  style={styleList({
    transform:
      direction === "up"
        ? `translateY(-${translateBy})`
        : `translateY(${translateBy})`,
  })}
>
  <button
    class={classList(
      "absolute h-16 transition-all hover:cursor-pointer",
      `flex justify-center ${direction === "up" ? "items-end" : "items-start"}`,
      direction === "up" ? "bottom-0" : ""
    )}
    style={styleList({ width: "calc(100% + 20px)" })}
    on:mouseenter={() => (hovered = true)}
    on:mouseleave={() => (hovered = false)}
    on:click={onclick}
  >
    <div
      class="pointer-events-none transition-all"
      transition:fly={{ y: direction === "up" ? -10 : 10, duration: 300 }}
    >
      {#if mode === "up"}
        <Icon src={ThumbUp} />
      {:else if mode === "down"}
        <Icon src={ThumbDown} />
      {:else if mode === "reset"}
        <Icon src={Restart} />
      {/if}
    </div>
  </button>
</div>
