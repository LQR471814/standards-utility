<script lang="ts">
  import { Icon } from "@steeze-ui/svelte-icon";
  import type { IconSource } from "@steeze-ui/svelte-icon/types";
  import { twMerge } from "tailwind-merge";

  import Panel from "~/components/common/Panel.svelte";

  export let icon: IconSource;

  export let containerName = "";
  export let className = "";

  export let bare = false;
  export let styleActionable = false;
</script>

<Panel
  {bare}
  {styleActionable}
  rounded="rounded-full"
  className={twMerge("w-fit h-fit centered mx-1", containerName)}
>
  <Icon src={icon} class={twMerge("m-2", className)} />
</Panel>
