import { SIZE_MATCH } from 'selector/src/main/ets/constants/Constants';

@Component
export struct ItemPicComponent {
  @Prop imagePath: string;

  build() {
    Image(this.imagePath)
      .width(SIZE_MATCH)
      .aspectRatio(1)
  }
}