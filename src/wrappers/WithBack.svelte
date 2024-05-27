<script lang="ts">
  import { Icon } from "@steeze-ui/svelte-icon";
  import { ArrowLeft } from "@steeze-ui/remix-icons";
  import { createEventDispatcher } from "svelte";
  import { classList } from "~/common/general";
  import { useClose } from "~/common/hooks";

  import Position from "~/wrappers/Position.svelte";

  const dispatcher = createEventDispatcher<{ close: { clicked: boolean } }>();
  useClose(() => dispatcher("close", { clicked: false }));
</script>

<slot />

<Position x="left" y="top">
  <button
    on:click={() => dispatcher("close", { clicked: true })}
    class={classList(
      "w-16 h-16 transition-all",
      "hover:scale-110 hover:cursor-pointer"
    )}
  >
    <Icon src={ArrowLeft} class="w-full h-full" />
  </button>
</Position>
