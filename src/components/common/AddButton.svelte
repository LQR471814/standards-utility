<script lang="ts">
  import { classList } from "~/common/general";
  import { Icon } from "@steeze-ui/svelte-icon";
  import { Add } from "@steeze-ui/remix-icons";

  export let labelFor: string;
</script>

<label
  for={labelFor}
  class={classList(
    "block m-4 w-16 h-16",
    "border-4 border-transparent rounded-full transition-all",
    "hover:border-slate-900 hover:scale-110 hover:cursor-pointer",
    "active:translate-y-1"
  )}
  on:click
  on:keydown
>
  <Icon src={Add} theme="solid" class="w-full h-full" />
</label>
