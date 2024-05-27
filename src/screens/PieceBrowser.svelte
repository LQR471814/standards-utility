<script lang="ts">
  import { createEventDispatcher, onDestroy } from "svelte";
  import { flip } from "svelte/animate";
  import { fly } from "svelte/transition";
  import { isTouch } from "~/common/platform";
  import { classList } from "~/common/general";

  import { pieces } from "~/state";
  import { imageStore } from "~/state/image";
  import type { Piece } from "~/proto/local/data";

  import Panel from "~/components/common/Panel.svelte";
  import Actionable from "~/components/common/Actionable.svelte";
  import { Icon } from "@steeze-ui/svelte-icon";
  import { Close, Edit } from "@steeze-ui/remix-icons";

  const dispatcher = createEventDispatcher<{
    choose: Piece;
    edit: Piece;
    delete: Piece;
  }>();

  let clicked = 0;

  $: pieceList = Object.values($pieces);

  onDestroy(() => {
    for (const p of pieceList) {
      imageStore.release(p.pages[0].image);
    }
  });
</script>

<div class="flex flex-wrap items-start justify-center h-full sm:justify-start">
  {#each pieceList as p (p.id)}
    <div
      transition:fly|local={{ x: -10 }}
      animate:flip={{ duration: 400 }}
      class="m-10 centered flex-col transition-all"
    >
      <Actionable
        on:click={() => {
          if (isTouch() && clicked < 1) {
            clicked++;
            return;
          }
          dispatcher("choose", p);
          clicked = 0;
        }}
        let:hovered
      >
        <Panel bare className="relative w-fit h-fit">
          <img
            class={classList(
              "object-contain mb-4 transition-all ease-in-out",
              hovered ? "blur-sm" : "",
              "shadow-lg rounded-2xl hover:cursor-pointer",
              "max-h-[400px] sm:max-h-80"
            )}
            src={imageStore.fetch(p.pages[0].image)}
            alt={`${p.name} cover`}
          />
          {#if hovered}
            <div class="absolute p-centered">
              <button
                transition:fly|local={{ y: 5 }}
                on:click={(e) => {
                  e.stopPropagation();
                  dispatcher("delete", p);
                }}
              >
                <Panel
                  rounded="rounded-full"
                  className="p-1 my-1"
                  styleActionable
                >
                  <Icon src={Close} />
                </Panel>
              </button>
              <button
                transition:fly|local={{ y: -5 }}
                on:click={(e) => {
                  e.stopPropagation();
                  dispatcher("edit", p);
                }}
              >
                <Panel
                  rounded="rounded-full"
                  className="p-1 my-1"
                  styleActionable
                >
                  <Icon src={Edit} />
                </Panel>
              </button>
            </div>
          {/if}
        </Panel>
      </Actionable>
      <h3 class="font-semibold text-2xl sm:text-xl">
        {p.name}
      </h3>
      <h4>{p.author}</h4>
    </div>
  {/each}
  {#if pieceList.length === 0}
    <h4 class="m-auto font-semibold">
      there are no pieces to practice at the moment
    </h4>
  {/if}
</div>
