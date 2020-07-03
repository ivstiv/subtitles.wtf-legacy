<template>
    <div class="subtitle-card">
        <h4 class="subtitle-card-title">{{ this.name }}</h4>
        <div class="subtitle-card-rating">
            <h6>
                <i class="fas fa-download"></i>
                 {{this.downloads}} | 
                <i class="fas fa-star"></i>
                 {{this.rating}}
            </h6>
        </div>
        <a :href="this.openLink" target="_blank">
            <div class="icon">
                <i class="fas fa-external-link-alt"></i>
            </div>
        </a>
        <a :href="this.downloadLink" target="_blank">
            <div class="icon">
                <i class="fas fa-download"></i>
            </div>
        </a>
    </div>
</template>

<style lang="scss" scoped>
@import '../styles/components/SubtitleCard.scss';
</style>

<script>
export default {
    props: ['name', 'downloads', 'rating', 'openLink', 'downloadLink'],
}
</script>