package com.tencent.mtt.hippy.example.view;

import android.view.View;
import com.tencent.mtt.hippy.annotation.HippyController;
import com.tencent.mtt.hippy.annotation.HippyControllerProps;
import com.tencent.mtt.hippy.dom.node.NodeProps;
import com.tencent.mtt.hippy.views.custom.HippyCustomPropsController;

@HippyController(name = HippyCustomPropsController.CLASS_NAME)
public class MyCustomViewController extends HippyCustomPropsController
{
	@HippyControllerProps(name = "customString", defaultType = HippyControllerProps.STRING, defaultString = "")
	public void setCustomString(View view, String text) {

	}
}
