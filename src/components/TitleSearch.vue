<template>
    <div class="card">
        <div class="search">
            <input type="text" class="search__input" placeholder="Movie title...">
            <div class="search__icon">
                <i class="fas fa-search"></i>
            </div>
            <div class="btn btn__primary">
                <p>Search</p>
            </div>
        </div>
        <p class="note">
            *If there are multiple movies with similar names 
            you can pick the exact match later.
        </p>
    </div>
</template>

<style lang="scss" scoped>
@import '../styles/components/TitleSearch.scss';
</style>