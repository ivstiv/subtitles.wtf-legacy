<template>
    <div>
        <h1 ref="title" class="title">SUBTITLES</h1>
        <div class="card">
            <div class="subtitles-header">
                <LanguageSearch></LanguageSearch>
                <SearchingDetails></SearchingDetails>
            </div>
            <!-- results underneath -->
        </div>
    </div>
</template>

<style lang="scss" scoped>
@import '../styles/components/SubtitlesResults.scss';
</style>

<script>
import LanguageSearch from './LanguageSearch.vue'
import SearchingDetails from './SearchingDetails.vue'

export default {
    components: {
        LanguageSearch,
        SearchingDetails
    }
}
</script>