<template>
    <!--<div class="uploadFile-wrapper" v-cloak @drop.prevent="addFile" @dragover.prevent>-->
    <div class="uploadFile-wrapper">
        <input type="file" ref="file" style="display: none" @change="uploadFile">
        <h1>Upload a movie (drag & drop)</h1>
        <div v-if="!uploadDisabled" class="btn btn__primary" @click="$refs.file.click()">
            <p>Upload</p>
        </div>
            <div v-if="uploadDisabled" class="chip" @click="removeFile()">
                <div class="chip__icon">
                    <i class="fas fa-file-video"></i>
                </div>
                <p>{{ movieFile.name }}</p>
                <div class="chip__close">
                    <i class="fas fa-times"></i>
                </div>
            </div>
        <p class="note">
            *You can drag & drop your movie file anywhere on the page.
            *The movie file is not actually uploaded, but processed locally.
        </p>
    </div>
</template>

<script>
import {EventBus} from '../event-bus'

export default {
    data() {
        return {
            movieFile: null
        }
    },

    computed: {
        uploadDisabled() {
            return this.movieFile;
        }
    },

    mounted() {
        EventBus.$on('file-upload', (file) => {
            this.movieFile = file;
            this.emitMovieHash();
        })
    },

    methods:{
        uploadFile(e) {
            let droppedFiles = e.target.files;
            if(!droppedFiles) return;
            this.movieFile = droppedFiles[0];
            this.emitMovieHash();
        },
        removeFile(){
            this.movieFile = null;
            this.$refs.file.value = "";
        },

        // TODO: link this to the search component  
        async emitMovieHash() {
            this.calculateHash(this.movieFile)
                .then(hash => {
                    console.log('Movie hash: '+hash);
                });
        },

        calculateHash(file) {
            return new Promise((resolve) => {
                // adapted from this page https://trac.opensubtitles.org/projects/opensubtitles/wiki/HashSourceCodes
                var HASH_CHUNK_SIZE = 65536, //64 * 1024
                longs = [],
                temp = file.size;

                function read(start, end, callback) {
                    var reader = new FileReader();
                    reader.onload = function(e) {
                        callback.call(reader, process(e.target.result));
                    };

                    if (end === undefined) {
                        reader.readAsBinaryString(file.slice(start));
                    } else {
                        reader.readAsBinaryString(file.slice(start, end));
                    }
                }

                function process(chunk) {
                    for (var i = 0; i < chunk.length; i++) {
                        longs[(i + 8) % 8] += chunk.charCodeAt(i);
                    }
                }

                function binl2hex(a) {
                    var b = 255,
                        d = '0123456789abcdef',
                        e = '',
                        c = 7;

                    a[1] += a[0] >> 8;
                    a[0] = a[0] & b;
                    a[2] += a[1] >> 8;
                    a[1] = a[1] & b;
                    a[3] += a[2] >> 8;
                    a[2] = a[2] & b;
                    a[4] += a[3] >> 8;
                    a[3] = a[3] & b;
                    a[5] += a[4] >> 8;
                    a[4] = a[4] & b;
                    a[6] += a[5] >> 8;
                    a[5] = a[5] & b;
                    a[7] += a[6] >> 8;
                    a[6] = a[6] & b;
                    a[7] = a[7] & b;
                    for (d, e, c; c > -1; c--) {
                        e += d.charAt(a[c] >> 4 & 15) + d.charAt(a[c] & 15);
                    }
                    return e;
                }


                for (var i = 0; i < 8; i++) {
                    longs[i] = temp & 255;
                    temp = temp >> 8;
                }

                read(0, HASH_CHUNK_SIZE, function() {
                    read(file.size - HASH_CHUNK_SIZE, undefined, function() {
                        resolve(binl2hex(longs));
                    });
                });
            });
        }
    }
}
</script>

<style lang="scss" scoped>
@import '../styles/components/UploadFile.scss';
</style>