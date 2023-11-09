package com.jackpot.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PlaceVO {
    private Long placeId;
    private String placeName;
    private String placeSpot;
    private Long placeTypeId;
}
