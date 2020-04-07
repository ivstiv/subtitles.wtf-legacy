<template>
  <div class="card">
    <div class="search">
      <input type="text" class="search__input" placeholder="Language..." />
      <div class="search__icon">
        <i class="fas fa-search"></i>
      </div>
      <div class="btn btn__primary">
        <p>Choose</p>
      </div>
    </div>
    <div class="chips">
      <div class="chip">
        <div class="chip__icon">
          <i class="far fa-flag"></i>
        </div>
        <p>Bulgarian</p>
        <div class="chip__close">
          <i class="fas fa-times"></i>
        </div>
      </div>
      <div class="chip">
        <div class="chip__icon">
          <i class="far fa-flag"></i>
        </div>
        <p>English</p>
        <div class="chip__close">
          <i class="fas fa-times"></i>
        </div>
      </div>
      <div class="chip">
        <div class="chip__icon">
          <i class="far fa-flag"></i>
        </div>
        <p>Indonesian</p>
        <div class="chip__close">
          <i class="fas fa-times"></i>
        </div>
      </div>
      <div class="chip">
        <div class="chip__icon">
          <i class="far fa-flag"></i>
        </div>
        <p>Polish</p>
        <div class="chip__close">
          <i class="fas fa-times"></i>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '../styles/components/LanguageSearch.scss';
</style>